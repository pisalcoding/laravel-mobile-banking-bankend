<?php

namespace App\Repositories\Menus;

use App\Models\MbTransactionChannel;
use App\Repositories\Contracts\IChannelMenusRepository;
use App\Repositories\Eloquent\BaseEloquentRepository;

class ChannelMenusRepository extends BaseEloquentRepository implements IChannelMenusRepository
{
    protected $model;

    public function __construct(MbTransactionChannel $model)
    {
        $this->model = $model;
    }
}
