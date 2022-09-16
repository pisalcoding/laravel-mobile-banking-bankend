<?php

use App\Http\Controllers\Api\MenusApiController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::group(['prefix' => 'v1_0_0'], function ($router) {
    Route::post('menus/home-menus', [MenusApiController::class, 'homeMenus']);
    Route::post('menus/trx-channels', [MenusApiController::class, 'trxChannels']);
});

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
