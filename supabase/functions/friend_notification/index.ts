import { createClient } from 'npm:@supabase/supabase-js@2'
import { JWT } from 'npm:google-auth-library@9'
import serviceAccount from '../service-account.json' with { type: 'json' }

interface FriendRequest {
  sender_id: string
  receiver_id: string
}

interface WebhookPayload {
  type: 'UPDATE'
  table: string
  record: FriendRequest
  schema: 'public'
}

const supabase = createClient(
  Deno.env.get('SUPABASE_URL')!,
  Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
)

Deno.serve(async (req) => {
  const payload: WebhookPayload = await req.json()

  const { data } = await supabase
    .from('users')
    .select('fcm_token')
    .eq('uid', payload.record.sender_id)
    .single()


  const { data: receiverData } = await supabase
    .from('users')
    .select('name')
    .eq('uid', payload.record.receiver_id)
    .single()

  const fcmToken = data!.fcm_token as string
  const name = receiverData!.name as string

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
            title: "You’ve Got a New Buddy!",
            body: `${name} accepted your request.`,
          },
          android: {
            "priority": "high",
            notification: {
              sound: 'default', // Use the device's default notification sound
              // Other Android notification options can be added here, e.g.,
              // channel_id: 'your_channel_id', // If using notification channels (recommended)
            },
        },
        },
      }),
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