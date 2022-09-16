<?php

namespace App\Repositories\Menus;

use App\Models\MbHomeMenu;
use App\Repositories\Contracts\IHomeMenusRepository;
use App\Repositories\Eloquent\BaseEloquentRepository;

class HomeMenusRepository extends BaseEloquentRepository implements IHomeMenusRepository
{

    protected $model;

    public function __construct(MbHomeMenu $model)
    {
        $this->model = $model;
    }
}
