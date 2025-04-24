<?php

namespace App\Http\Controllers;

use App\Services\SupabaseService;
use Illuminate\Http\Request;
use Inertia\Inertia;


class CustomerController extends Controller
{
    protected $supabaseService;
    
    public function __construct(SupabaseService $supabaseService)
    {
        $this->supabaseService = $supabaseService;
    }
    
    public function index()
    {
        $customers = $this->supabaseService->getCustomerNames();
        
        return Inertia::render('Customers', [
            'customers' => $customers
        ]);
    }
    
    public function api()
    {
        $customers = $this->supabaseService->getCustomerNames();
        
        return response()->json([
            'customers' => $customers
        ]);
    }

    public function anime_fav_title(){
        $anime_title = $this->supabaseService->getFavAnimeCharacter();

        return Inertia::render('FavAnimeTitle', [
            'anime_title' => $anime_title
        ]);
    }
}