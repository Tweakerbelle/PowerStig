# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.

using module ..\helper.psm1
using module ..\..\PowerStig.psm1

<#
    .SYNOPSIS
        A composite DSC resource to manage the SharePoint STIG settings.
    .PARAMETER SharePointVersion
        The version of SharePoint being used E.g. 'Server2012'
    .PARAMETER SharePointRole
        There are two STIGs that cover the scope of SharePoint_ SharePoint Instance covers each instance of SharePoint on a server
        SharePoint Database covers each Database within an Instance.
    .PARAMETER StigVersion
        The version of the SharePoint STIG to apply and/or monitor
    .PARAMETER Exception
        A hashtable of StigId=Value key pairs that are injected into the STIG data and applied to
        the target node. The title of STIG settings are tagged with the text ‘Exception’ to identify
        the exceptions to policy across the data center when you centralize DSC log collection.
    .PARAMETER OrgSettings
        The path to the xml file that contains the local organizations preferred settings for STIG
        items that have allowable ranges.  The OrgSettings parameter also accepts a hashtable for
        values that need to be modified.  When a hashtable is used, the specified values take
        presidence over the values defined in the org.default.xml file.
    .PARAMETER SkipRule
        The SkipRule Node is injected into the STIG data and applied to the taget node. The title
        of STIG settings are tagged with the text 'Skip' to identify the skips to policy across the
        data center when you centralize DSC log collection.
    .PARAMETER SkipRuleType
        All STIG rule IDs of the specified type are collected in an array and passed to the Skip-Rule
        function. Each rule follows the same process as the SkipRule parameter.
#>

configuration SharePoint_SPWebAppGeneralSettings
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $WebAppUrl,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [pscredential]
        $SetupAccount,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [version]
        $StigVersion,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Exception,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [object]
        $OrgSettings,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $SkipRule,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $SkipRuleType
    )

    ##### BEGIN DO NOT MODIFY #####
    $stig = [STIG]::New('SharePoint_SPWebAppGeneralSettings', $SharePointVersion, $StigVersion)
    $stig.LoadRules($OrgSettings, $Exception, $SkipRule, $SkipRuleType)
    ##### END DO NOT MODIFY #####

    Import-DscResource -ModuleName SharePointDSC -ModuleVersion 4.0.0.0
    . "$resourcePath\SharePoint_SPWebAppGeneralSettings.ps1"
    
}