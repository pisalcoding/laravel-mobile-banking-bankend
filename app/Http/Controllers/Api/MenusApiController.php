<?php

namespace App\Http\Controllers\Api;

use App\Services\Contracts\IMenusService;
use Illuminate\Support\Facades\Request;
use App\Http\Controllers\Api\BaseApiController;

class MenusApiController extends BaseApiController
{
    protected $menusService;

    function __construct(IMenusService $service)
    {
        $this->menusService = $service;
    }

    function homeMenus(Request $request)
    {
        $data = $this->menusService->homeMenus($request);
        return $this->jsonResponse(
            $data,
            true,
            "Sucess"
        );
    }

    function paymentChannels(Request $request)
    {
        $data = $this->menusService->paymentChannelMenus($request);
        return $this->jsonResponse(
            $data,
            true,
            "Sucess"
        );
    }

    function transferChannels(Request $request)
    {
        $data = $this->menusService->transferChannelMenus($request);
        return $this->jsonResponse(
            $data,
            true,
            "Sucess"
        );
    }

    function newAccounts(Request $request)
    {
        $data = $this->menusService->newAccountMenus($request);
        return $this->jsonResponse(
            $data,
            true,
            "Sucess"
        );
    }

    function loans(Request $request)
    {
        $data = $this->menusService->loanMenus($request);
        return $this->jsonResponse(
            $data,
            true,
            "Sucess"
        );
    }
}
