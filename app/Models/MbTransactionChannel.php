<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MbTransactionChannel extends Model
{
    use HasFactory;

    protected $hidden = ["type", "parent_id", "created_at", "updated_at", "history"];

    const MENU_PAYMENT = "PAYMENT";
    const MENU_TRANSFER = "TRANSFER";
    const MENU_NEW_ACCOUNT = "NEW_ACCOUNT";
    const MENU_LOANS = "LOANS";
}
