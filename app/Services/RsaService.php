<?php

namespace App\Services;

use App\Services\Contracts\IRsaService;
use phpseclib3\Crypt\RSA\PrivateKey;
use phpseclib3\Crypt\RSA\PublicKey;

class RsaService implements IRsaService
{
    private PrivateKey $private;

    function __construct(PrivateKey $privateKey)
    {
        $this->private = $privateKey;
    }

    function decrypt($cipherText)
    {
        return $this->private->decrypt($cipherText);
    }

    function verifySignature(string $pubKeyPlain, string $message, string $signature)
    {
    }

    function encryptWithPrivate(string $cipherText)
    {
        // return $this->private->encrypt($cipherText);
    }

    function encryptWithPublic(string $cipherText)
    {
        $public = new PublicKey();
        return $this->private->getPublicKey()->encrypt($cipherText);
    }
}
