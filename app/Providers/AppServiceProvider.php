<?php

namespace App\Providers;

use App\Services\AesService;
use App\Services\Contracts\IAesService;
use App\Services\Contracts\IMenusService;
use App\Services\Contracts\IRsaService;
use App\Services\MenusService;
use App\Services\RsaService;
use Illuminate\Support\ServiceProvider;
use phpseclib3\Crypt\RSA;
use phpseclib3\Crypt\RSA\PrivateKey;

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
        $this->app->singleton(PrivateKey::class, function () {
            $privateKeyPlain = env("RSA_PRIVATE_KEY");
            $privateKey = RSA::load($privateKeyPlain)
                ->withPadding(RSA::ENCRYPTION_PKCS1 | RSA::SIGNATURE_PKCS1);
            return $privateKey;
        });

        $this->app->bind(IRsaService::class, RsaService::class);
        $this->app->bind(IAesService::class, AesService::class);

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
