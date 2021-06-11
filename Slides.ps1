function Get-Slide {
    param (
        # Parameter help description
        [Parameter()]
        [ValidateSet("1_Intro", "2_What", "3_Versions", "4_Modules", "5_Story", "6_Summary")]
        $Slide
    )

    $slides = @{
        '1_Intro'    = "
    /---------------------------------------------------------\
    | " + "$($color.orange)`u{e706}$($color.reset) " * 28 + "|
    |                                                         |
    |        A speedy Intro to PowerShell                     |
    |                                                         |
    |        By                                               |
    |          Jess Pomfret        $($color.orange)`u{f408}$($color.reset) jpomfret/IntroPowerShell |
    |          (She\Her)           $($color.orange)`u{f6ef}$($color.reset) jpomfret7@gmail.com      |
    |                              $($color.orange)`u{f099}$($color.reset) @jpomfret                |
    \---------------------------------------------------------/
    "
        '2_What'     = '
    What Is PowerShell?
    --------------------------------------------------------------------
    PowerShell is a cross-platform task automation solution made up of:
    - command-line shell
    - scripting language
    - configuration management framework
    '

        '3_Versions' = '
    Windows PowerShell Vs PowerShell
    --------------------------------------------------------------------
    - Windows PowerShell (5.1) - installed by default with Windows
    - PowerShell (7.1) - Cross platform PowerShell with cool new features

    $PSVersionTable

    '
        '4_Modules'  = '
    Modules
    --------------------------------------------------------------------
    - a self-contained, reusable container of scripts
    - write your own, or find an existing community module
    - PowerShell Gallery - Central repository for PowerShell Content

    Find-Module -Name dbatools
    Install-Module -Name dbatools
    Import-Module -Name dbatools

    '
        '5_Story'    = '
    Are my databases being backed up?
    --------------------------------------------------------------------
    - When was the last full backups for all SQL Servers
    - How long will it take to connect & check each one in SSMS?

    Get-Command -Name *backup*
    Find-DbaCommand -Pattern *backup*
    Get-Help
    '

        '6_Summary'  = "
    /---------------------------------------------------\
    | " + "$($color.orange)`u{fcf8}$($color.reset) " * 25 + "|
    |                                                   |
    |        Thanks for joining me!                     |
    |                                                   |
    |        Summary:                                   |
    |         $($color.orange)`u{f44a}$($color.reset) Find-Module                             |
    |         $($color.orange)`u{f44a}$($color.reset) Get-Command                             |
    |         $($color.orange)`u{f44a}$($color.reset) Get-Help                                |
    |                        $($color.orange)`u{f408}$($color.reset) jpomfret/IntroPowerShell |
    |                        $($color.orange)`u{f6ef}$($color.reset) jpomfret7@gmail.com      |
    |                        $($color.orange)`u{f099}$($color.reset) @jpomfret                |
    \---------------------------------------------------/

    "

    }

    Cls
    return $slides[$slide]
}


