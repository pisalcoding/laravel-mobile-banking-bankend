<?php

namespace App\Services;

use App\Services\Contracts\AesResult;
use App\Services\Contracts\IAesService;
use phpseclib3\Crypt\AES;
use phpseclib3\Crypt\Random;

class AesService implements IAesService
{

    /**
     * Recommended by OWASP: 16 (bytes)
     */
    private int $aesKeySizeInBytes = 16;

    /**
     * Recommended by OWASP: 16 (bytes)
     */
    private string $aesMode = "cbc";

    // /**
    //  * Recommended by OWASP: "AES/CBC/PKCS7Padding"
    //  */
    // private string $aesMode = "AES/CBC/PKCS7Padding";

    /**
     * Recommended: 100 good an equilibrium between robustness and performance.
     * The bigger, the more secure, but slower at the same time.
     */
    private int $keyIterationCount = 100;

    function encrypt($password, $message): AesResult
    {
        $salt = Random::string(8);
        $iv = Random::string(16);
        $cipher = new AES($this->aesMode);
        $cipher->setIV($iv);
        $cipher->enablePadding();
        $cipher->setPassword(
            $password,
            'pbkdf2',
            'sha1',
            $salt,
            $this->keyIterationCount,
            $this->aesKeySizeInBytes
        );
        $cipherText = $cipher->encrypt($message);

        return new AesResult(
            base64_encode($iv),
            base64_encode($salt),
            base64_encode($cipherText)
        );
    }

    function decrypt(
        string $password,
        string $salt,
        string $iv,
        string $base64CipherText
    ): string {

        $cipher = new AES($this->aesMode);
        $cipher->setIV($iv);
        $cipher->enablePadding();
        $cipher->setPassword(
            $password,
            'pbkdf2',
            'sha1',
            $salt,
            $this->keyIterationCount,
            $this->aesKeySizeInBytes
        );

        return $cipher->decrypt(base64_decode($base64CipherText));
    }
}
