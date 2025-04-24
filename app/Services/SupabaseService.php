<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;

class SupabaseService
{
    protected $baseUrl;
    protected $apiKey;
    
    public function __construct()
    {
        $this->baseUrl = env('SUPABASE_URL');
        $this->apiKey = env('SUPABASE_KEY');
    }
    
    public function getCustomerNames()
    {
        $response = Http::withHeaders([
            'apikey' => $this->apiKey,
            'Authorization' => 'Bearer ' . $this->apiKey,
        ])->get($this->baseUrl . '/rest/v1/customer_name', [
            'select' => '*'
        ]);
        
        if ($response->successful()) {
            return $response->json();
        }
        
        return [];
    }

    public function getFavAnimeCharacter(){
        $response = Http::withHeaders([
            'apikey' => $this->apiKey,
            'Authorization' => 'Bearer ' . $this->apiKey,
        ])->get($this->baseUrl . '/rest/v1/fav_anime_title', [
            'select' => '*'
        ]);

        if($response->successful()){
            return $response->json();
        }

        return [];
    }
}