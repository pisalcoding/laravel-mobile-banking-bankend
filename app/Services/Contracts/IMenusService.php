<?php

namespace App\Services\Contracts;

use Illuminate\Support\Facades\Request;

interface IMenusService
{
    function homeMenus(Request $request);
    function paymentChannelMenus(Request $request);
    function transferChannelMenus(Request $request);
    function newAccountMenus(Request $request);
    function loanMenus(Request $request);
}
