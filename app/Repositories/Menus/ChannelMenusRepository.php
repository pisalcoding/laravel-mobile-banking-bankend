<?php

namespace App\Repositories\Menus;

use App\Models\MbTransactionChannel;
use App\Repositories\Contracts\IChannelMenusRepository;
use App\Repositories\Eloquent\BaseEloquentRepository;
use Exception;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Redis;

class ChannelMenusRepository extends BaseEloquentRepository implements IChannelMenusRepository
{
    protected $model;

    public function __construct(MbTransactionChannel $model)
    {
        $this->model = $model;
    }

    function paymentChannelMenus()
    {
        return $this->getAndCacheMenus(MbTransactionChannel::MENU_PAYMENT, "ChannelMenusRepository.paymentChannelMenus");
    }

    function transferChannelMenus()
    {
        return $this->getAndCacheMenus(MbTransactionChannel::MENU_TRANSFER, "ChannelMenusRepository.transferChannelMenus");
    }

    function newAccountMenus()
    {
        return $this->getAndCacheMenus(MbTransactionChannel::MENU_NEW_ACCOUNT, "ChannelMenusRepository.newAccountMenus");
    }

    function loanMenus()
    {
        return $this->getAndCacheMenus(MbTransactionChannel::MENU_LOANS, "ChannelMenusRepository.loanMenus");
    }

    /**
     * Get menus:
     * If cached, return cached.
     * If not cached, fetch and save cache.
     */
    private function getAndCacheMenus(string $type, string $cacheKey)
    {
        try {
            $cache = Redis::get($cacheKey);
            if ($cache) {
                return json_decode($cache);
            }

            $result = $this->model
                ->where('type', $type)
                ->where('status', 1)
                ->select([
                    'id',
                    'type as typ',
                    'service_code as sco',
                    'terminal_code as tco',
                    'title as ttl',
                    'subtitle as stt',
                    'icon as ico',
                    'local_drawable_id as loc',
                    'requires_auth as aut',
                    'needs_icon_outline as out',
                    'uses_circular_icon as cir',
                    'sub_button_text as sbt',
                    'highlight_icons as ics',
                    'enabled as ena',
                    'status as sta',
                    'version as ver'
                ])
                ->get();
            Redis::set($cacheKey, $result);
            return $result;
        } catch (Exception $e) {
            Log::error("ChannelMenusRepository.getAndCacheMenus:$cacheKey", ['exception' => $e]);
            return null;
        }
    }
}
