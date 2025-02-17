import { createClient } from 'npm:@supabase/supabase-js@2'
import { JWT } from 'npm:google-auth-library@9'
import serviceAccount from '../service-account.json' with { type: 'json' }



interface OpenSocialNotificationPayload {
  social: string
  user_id: string
  friend_id: string
}

const supabase = createClient(
  Deno.env.get('SUPABASE_URL')!,
  Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
)

Deno.serve(async (req) => {
  const payload: OpenSocialNotificationPayload = await req.json()

  const { data: friendData } = await supabase
    .from('users')
    .select('fcm_token')
    .eq('uid', payload.friend_id)
    .single()


  const { data: userData } = await supabase
    .from('users')
    .select('name, images')
    .eq('uid', payload.user_id)
    .single()

  const fcmToken = friendData!.fcm_token as string
  const name = userData!.name as string
  const image = Array.isArray(userData!.images as string0)[0];

  const accessToken = await getAccessToken({
    clientEmail: serviceAccount.client_email,
    privateKey: serviceAccount.private_key,
  })

  const res = await fetch(
    `https://fcm.googleapis.com/v1/projects/${serviceAccount.project_id}/messages:send`,
    {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${accessToken}`,
      },
      body: JSON.stringify({
        message: {
          token: fcmToken,
          notification: {
            title: `Social Visit Alert!`,
            body: `${name} just visit your ${payload.social}`,
            image, 
           
          },
          android: {
            "priority": "high",
              notification: {
              sound: 'default', // Use the device's default notification sound
              image, 
              // Other Android notification options can be added here, e.g.,
              // channel_id: 'your_channel_id', // If using notification channels (recommended)
            },
          },
        },
      }
    ),
    }
  )

  const resData = await res.json()
  if (res.status < 200 || 299 < res.status) {
    throw resData
  }

  return new Response(JSON.stringify(resData), {
    headers: { 'Content-Type': 'application/json' },
  })
})

const getAccessToken = ({
  clientEmail,
  privateKey,
}: {
  clientEmail: string
  privateKey: string
}): Promise<string> => {
  return new Promise((resolve, reject) => {
    const jwtClient = new JWT({
      email: clientEmail,
      key: privateKey,
      scopes: ['https://www.googleapis.com/auth/firebase.messaging'],
    })
    jwtClient.authorize((err, tokens) => {
      if (err) {
        reject(err)
        return
      }
      resolve(tokens!.access_token!)
    })
  })
}