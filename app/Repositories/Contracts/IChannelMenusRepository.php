<?php

namespace App\Repositories\Contracts;

use App\Repositories\Eloquent\IEloquentRepository;

interface IChannelMenusRepository extends IEloquentRepository
{
    function paymentChannelMenus();
    function transferChannelMenus();
    function newAccountMenus();
    function loanMenus();
}
