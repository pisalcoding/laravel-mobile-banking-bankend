<?php

namespace App\Services\Contracts;

interface IAesService
{
    function encrypt($password, $message): AesResult;

    function decrypt(
        string $password,
        string $salt,
        string $iv,
        string $base64CipherText
    ): string;
}
