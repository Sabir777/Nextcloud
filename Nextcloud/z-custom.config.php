<?php
if (!isset($CONFIG) || !is_array($CONFIG)) {
    $CONFIG = array();
}

$CONFIG += array(
  'default_phone_region' => 'RU',
  'overwriteprotocol' => 'https',
  'forwarded_for_headers' => array('HTTP_X_FORWARDED_FOR'),
  'upgrade.disable-web' => true,
);
