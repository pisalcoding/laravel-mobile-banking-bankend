<?php

namespace App\Services;

use App\Repositories\Contracts\IChannelMenusRepository;
use App\Repositories\Contracts\IHomeMenusRepository;
use App\Services\Contracts\IMenusService;
use Illuminate\Support\Facades\Request;

class MenusService implements IMenusService
{
    private $homeMenus;
    private $trxChannels;

    function __construct(IHomeMenusRepository $homeMenus, IChannelMenusRepository $trxChannels)
    {
        $this->homeMenus = $homeMenus;
        $this->trxChannels = $trxChannels;
    }

    function homeMenus(Request $request)
    {
        return $this->homeMenus->all();
    }

    function trxChannelMenus(Request $request)
    {
        return $this->trxChannels->all();
    }
}
