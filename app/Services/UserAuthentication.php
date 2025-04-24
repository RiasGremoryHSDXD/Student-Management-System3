<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;

class UserAuthentication
{
    protected string $rpcUrl;
    protected string $apiKey;

    public function __construct()
    {
        // Base URL for Supabase PostgREST RPC endpoint
        $baseUrl = rtrim(env('SUPABASE_URL'), '/');                               // Ensure no trailing slash :contentReference[oaicite:0]{index=0}
        $this->rpcUrl = "{$baseUrl}/rest/v1/rpc/user_auth";                       // RPC function endpoint :contentReference[oaicite:1]{index=1}
        $this->apiKey = env('SUPABASE_KEY');                                      // Service role or anon key :contentReference[oaicite:2]{index=2}
    }

    /**
     * Call the Supabase user_auth function via RPC and return the match count.
     *
     * @param  string  $email     The email to authenticate.
     * @param  string  $password  The password to verify.
     * @return int               Number of matches (0 or 1).
     */
    public function user_authentication(string $email, string $password): int
    {
        // Send POST request with JSON payload
        $response = Http::withHeaders([
            'apikey'        => $this->apiKey,                                   // Required apikey header :contentReference[oaicite:3]{index=3}
            'Authorization' => 'Bearer ' . $this->apiKey,                       // Bearer auth header :contentReference[oaicite:4]{index=4}
            'Content-Type'  => 'application/json',
            'Accept'        => 'application/json',
        ])->post($this->rpcUrl, [
            'user_email_input'    => $email,                                    // Function param 1
            'user_password_input' => $password,                                 // Function param 2
        ]);                                                                    // HTTP::post sends JSON by default 

        // Decode JSON response: Supabase returns [ { "user_auth": <int> } ]
        $data = $response->json();

        // Extract and return the integer count, default 0
        return isset($data[0]['user_auth']) ? (int) $data[0]['user_auth'] : 0;
    }
}
