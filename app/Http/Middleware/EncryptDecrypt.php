<?php

namespace App\Http\Middleware;

use App\Commons\ResponseWrapper;
use App\Services\Contracts\IAesService;
use App\Services\Contracts\IRsaService;
use Closure;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class EncryptDecrypt
{

    const KEY_REQUEST_PASSWORD = "a";
    const KEY_RESPONSE_PASSWORD = "b";
    const KEY_SIGNATURE = "c";
    const KEY_IV = "x";
    const KEY_SALT = "y";
    const KEY_CIPHER_TEXT = "z";

    private IRsaService $rsa;
    private IAesService $aes;

    function __construct(IRsaService $rsa, IAesService $aes)
    {
        $this->rsa = $rsa;
        $this->aes = $aes;
    }

    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next)
    {
        if (!env("ENCRYPT_API")) {
            return $next($request);
        }

        try {
            $decryptedBody = $this->decryptRequest($request);
            $newRequest = Request::createFrom($request);
            $newRequest->setJson($decryptedBody);

            $rawResponse = $next($newRequest);
            $encryptedResponsePassword = base64_decode($request->json()->get(EncryptDecrypt::KEY_RESPONSE_PASSWORD));
            $responsePassword = $this->rsa->decrypt($encryptedResponsePassword);
            if (!$responsePassword) {
                throw new Exception("Missing response password!");
            }

            $content = $rawResponse->getContent();
            $encryptedContent = $this->aes->encrypt($responsePassword, $content);
            return response()->json($encryptedContent->jsonSerialize(), $rawResponse->getStatusCode());
        } catch (Exception $ex) {
            Log::error("EncryptDecrypt:handle:error:: $ex");
            $result = new ResponseWrapper(
                400,
                false,
                safeMessage($ex, "Bad request param!"),
                null
            );
            return response()->json($result->jsonSerialize(), 400);
        }
    }

    private function decryptRequest(Request $request)
    {
        $json = $request->json();

        if (!$json) {
            throw new Exception("Missing body!");
        }

        $signature = $this->rsa->decrypt(base64_decode($json->get(EncryptDecrypt::KEY_SIGNATURE)));
        if (!$signature) {
            throw new Exception("Missing signature!");
        }

        $requestPassword = $this->rsa->decrypt(base64_decode($json->get(EncryptDecrypt::KEY_REQUEST_PASSWORD)));
        if (!$requestPassword) {
            throw new Exception("Missing request password!");
        }

        $salt = $this->rsa->decrypt(base64_decode($json->get(EncryptDecrypt::KEY_SALT)));
        if (!$salt) {
            throw new Exception("Missing salt!");
        }

        $iv = $this->rsa->decrypt(base64_decode($json->get(EncryptDecrypt::KEY_IV)));
        if (!$iv) {
            throw new Exception("Missing iv!");
        }

        $data = $json->get(EncryptDecrypt::KEY_CIPHER_TEXT);
        if (!$data) {
            throw new Exception("Missing data!");
        }

        $decryptedMessage = $this->aes->decrypt($requestPassword, base64_decode($salt), base64_decode($iv), $data);
        if (!$this->verifyChecksum($decryptedMessage, $signature)) {
            throw new Exception("Failed checksum!");
        }

        return $decryptedMessage;
    }

    private function verifyChecksum(string $message, string $checksum): bool
    {
        Log::info("EncryptDecrypt:verifyChecksum:checksum:: $checksum");
        $serverChecksum = hash('sha512', $message);
        Log::info("EncryptDecrypt:verifyChecksum:serverChecksum:: $serverChecksum");
        return $serverChecksum == $checksum;
    }
}
