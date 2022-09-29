<?php

namespace App\Services\Contracts;

interface IRsaService
{
    /**
     * Decrypt cipher text with server's private key
     */
    function decrypt($cipherText);

    /**
     * Encrypt plain text with server's public key
     */
    function encryptWithPublic(String $cipherText);

    /**
     * Encrypt plain text with server's private key
     */
    function encryptWithPrivate(String $cipherText);

    /**
     * Verify signature of message with client's public key
     */
    function verifySignature(String $pubKeyPlain, String $message, String $signature);
}
