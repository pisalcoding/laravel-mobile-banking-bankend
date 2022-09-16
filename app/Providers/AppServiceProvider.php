<?php

namespace App\Providers;

use App\Services\Contracts\IMenusService;
use App\Services\MenusService;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->register(RepositoriesServiceProvider::class);
        $this->registerServices();
    }

    private function registerServices()
    {
        $this->app->bind(IMenusService::class, MenusService::class);
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }
}
