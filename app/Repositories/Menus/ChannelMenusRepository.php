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
        try {
            $cache = Redis::get("ChannelMenusRepository.paymentChannelMenus");
            if ($cache) {
                return json_decode($cache);
            }

            $result = $this->model
                ->where('type', MbTransactionChannel::MENU_PAYMENT)
                ->select([
                    'id',
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
            Redis::set("ChannelMenusRepository.paymentChannelMenus", $result);
            return $result;
        } catch (Exception $e) {
            Log::error("ChannelMenusRepository.paymentChannelMenus:", ['exception' => $e]);
            return null;
        }
    }

    function transferChannelMenus()
    {
        try {
            $cache = Redis::get("ChannelMenusRepository.transferChannelMenus");
            if ($cache) {
                return json_decode($cache);
            }

            $result = $this->model
                ->where('type', MbTransactionChannel::MENU_TRANSFER)
                ->select([
                    'id',
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
            Redis::set("ChannelMenusRepository.transferChannelMenus", $result);
            return $result;
        } catch (Exception $e) {
            Log::error("ChannelMenusRepository.transferChannelMenus:", ['exception' => $e]);
            return null;
        }
    }
}
