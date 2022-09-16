<?php

namespace App\Providers;

use App\Repositories\Contracts\IChannelMenusRepository;
use App\Repositories\Contracts\IHomeMenusRepository;
use App\Repositories\Menus\ChannelMenusRepository;
use App\Repositories\Menus\HomeMenusRepository;
use App\Repository\Eloquent\BaseEloquentRepository;
use Illuminate\Support\ServiceProvider;

class RepositoriesServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->bind(IEloquentRepository::class, BaseEloquentRepository::class);
        $this->app->bind(IHomeMenusRepository::class, HomeMenusRepository::class);
        $this->app->bind(IChannelMenusRepository::class, ChannelMenusRepository::class);
    }

    /**
     * Bootstrap services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }
}
