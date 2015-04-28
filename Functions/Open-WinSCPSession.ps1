<#
.SYNOPSIS
    This is the main interface class of the WinSCP assembly.
.DESCRIPTION
    Creates a new WINSCP.Session Object with setting specified in the WinSCP.SessionOptions object.  Assign this Object to a Variable to easily manipulate actions later.
.INPUTS
    WinSCP.SessionOptions.
.OUTPUTS
    WinSCP.Session.
.PARAMETER SessionOptions
    Defines information to allow an automatic connection and authentication of the session.
.PARAMETER SessionLogPath
    Path to store session log file to. Default null means, no session log file is created.
.PARAMETER DebugLogPath
    Path to store assembly debug log to. Default null means, no debug log file is created. See also SessionLogPath. The property has to be set before calling Open.
.EXAMPLE
    PS C:\> $session = Open-WinSCPSession -SessionOptions (New-WinSCPSessionOptions -Hostname myftphost.org -Username ftpuser -password "FtpUserPword" -Protocol Ftp)
    PS C:\> $session

    ExecutablePath                : 
    AdditionalExecutableArguments : 
    DefaultConfiguration          : True
    DisableVersionCheck           : False
    IniFilePath                   : 
    ReconnectTime                 : 10675199.02:48:05.4775807
    DebugLogPath                  : 
    SessionLogPath                : 
    XmlLogPath                    : C:\Users\user\AppData\Local\Temp\wscp0708.03114C7C.tmp
    Timeout                       : 00:01:00
    Output                        : {winscp> option batch on, batch           on        , winscp> option confirm off, confirm         off       ...}
    Opened                        : True
    UnderlyingSystemType          : WinSCP.Session
.EXAMPLE
    PS C:\> $session = New-WinSCPSessionOptions -Hostname myftphost.org -Username ftpuser -password "FtpUserPword" -Protocol Ftp | Open-WinSCPSession
    PS C:\> $session

    ExecutablePath                : 
    AdditionalExecutableArguments : 
    DefaultConfiguration          : True
    DisableVersionCheck           : False
    IniFilePath                   : 
    ReconnectTime                 : 10675199.02:48:05.4775807
    DebugLogPath                  : 
    SessionLogPath                : 
    XmlLogPath                    : C:\Users\user\AppData\Local\Temp\wscp0708.03114C7C.tmp
    Timeout                       : 00:01:00
    Output                        : {winscp> option batch on, batch           on        , winscp> option confirm off, confirm         off       ...}
    Opened                        : True
    UnderlyingSystemType          : WinSCP.Session
.NOTES
    If the WinSCPSession is piped into another WinSCP command, the connection will be disposed upon completion of that command.
    Be sure to store the WinSCPSession into a vairable, else there will be no handle to use with it.
.INPUTS
    WinSCP.SessionOptions.
.OUTPUTS
    WinSCP.Session.
.LINK
    http://dotps1.github.io/WinSCP
.LINK
    http://winscp.net/eng/docs/library_session
#>
Function Open-WinSCPSession
{
    [CmdletBinding()]
    [OutputType([WinSCP.Session])]

    Param
    (   
        [Parameter(Mandatory = $true,
                   ValueFromPipeLine = $true)]
        [WinSCP.SessionOptions]
        $SessionOptions,

        [Parameter()]
        [String]
        $SessionLogPath = $null,

        [Parameter()]
        [String]
        $DebugLogPath = $null
    )

    $session = New-Object -TypeName WinSCP.Session -Property @{
        SessionLogPath = $SessionLogPath
        DebugLogPath = $DebugLogPath
    }
    
    try
    {
        $session.Open($SessionOptions)
        return $session
    }
    catch [System.Exception]
    {
        throw $_
    }
}