<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MbHomeMenu extends Model
{
    use HasFactory;

    protected $hidden = ["type", "parent_id", "created_at", "updated_at", "history"];
}
