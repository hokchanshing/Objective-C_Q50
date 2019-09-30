<?php
$deviceToken = '323236c6a3d4db14a1c8d990db1d0e36c69d1f5288979bf3a4182058386ab726';

$body = array();
$body['aps']['alert']['title'] = 'iOS10プッシュ通知テスト';
$body['aps']['alert']['subtitle'] = 'SubTitle';
$body['aps']['alert']['body'] = 'Body';
$body['aps']['sound'] = 'sound1.aiff';
$body['aps']['badge'] = 1;
$body['aps']['mutable-content'] = 1;
$body['image-url'] = 'https://1.bp.blogspot.com/-s7wD--x4LBo/WUJZO318J0I/AAAAAAABE1k/cLyYpUhHxzou8EfHWbcd02LpnTfHU006gCLcBGAs/s1600/logo_sml.png';
$body['category'] = 'myNotificationCategory';


// SSL証明書
$cert = 'aps_developments.pem';
//$cert = 'aps_production.pem';

$url = 'ssl://gateway.sandbox.push.apple.com:2195'; // 開発用
//$url = 'ssl://gateway.push.apple.com:2195'; // 本番用

$context = stream_context_create();
stream_context_set_option( $context, 'ssl', 'local_cert', $cert );
$fp = stream_socket_client( $url, $err, $errstr, 60, STREAM_CLIENT_CONNECT, $context );

if( !$fp ) {

    echo 'Failed to connect.' . PHP_EOL;
    exit( 1 );

}

$payload = json_encode( $body );
$message = chr( 0 ) . pack( 'n', 32 ) . pack( 'H*', $deviceToken ) . pack( 'n', strlen($payload ) ) . $payload;

print 'send message:' . $payload . PHP_EOL;

fwrite( $fp, $message );
fclose( $fp );
echo 'end';
