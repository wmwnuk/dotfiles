<?php

use Rector\Config\RectorConfig;
use Rector\Core\ValueObject\PhpVersion;
use Rector\Set\ValueObject\SetList;

return static function (RectorConfig $rectorConfig): void {
    $rectorConfig->sets([SetList::PHP_81, SetList::CODING_STYLE, SetList::CODE_QUALITY, SetList::DEAD_CODE, SetList::STRICT_BOOLEANS]);
    $rectorConfig->phpVersion(PhpVersion::PHP_81);
    $rectorConfig->removeUnusedImports();
    $rectorConfig->importNames();
    $rectorConfig->importShortClasses();
};
