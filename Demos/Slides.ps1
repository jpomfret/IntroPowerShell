Import-Module Pansies

# dot source the pacman
.  .\Demos\pacman.ps1

# open edge so we can kill it later
1..10 | % { Start-Process www.sqlbits.com }

# get rid of the test folder
if((Test-Path .\Test)){
    Remove-Item .\Test -Recurse -Force    
}

# docker compose up some containers
docker-compose -f .\Docker\docker-compose.yml up -d

function Get-Slide {
    param (
        # Parameter help description
        [Parameter()]
        #[ValidateSet("1_Intro", "2_What", "3_Versions", "4_Modules", "5_Story", "6_Summary")]
        $Slide
    )
    write-host $slide
    $slides = @(
    
    # Slide 0
    "
    /---------------------------------------------------------\
    | " + "$($color.orange)`u{f796}$($color.reset) " * 28 + "|
    |                                                         |
    |        Intro to PowerShell                              |
    |                                                         |
    |        By                                               |
    |          Jess Pomfret        $($color.orange)`u{f408}$($color.reset) jpomfret/IntroPowerShell |
    |          (She\Her)           $($color.orange)`u{f6ef}$($color.reset) jpomfret7@gmail.com      |
    |                              $($color.orange)`u{f099}$($color.reset) @jpomfret                |
    \---------------------------------------------------------/
    "
    # Slide 1
    '
    What Is PowerShell?
    --------------------------------------------------------------------
    PowerShell is a cross-platform task automation solution made up of:
    
    - command-line shell
    - scripting language
    - configuration management framework
    '
    # Slide 2
    '
    Windows PowerShell Vs PowerShell
    --------------------------------------------------------------------
    - Windows PowerShell (5.1) - installed by default with Windows
    - PowerShell (7.2) - Cross platform PowerShell with cool new features

    $PSVersionTable

    '
    # Slide 3
    '
    PowerShell Basics - File System
    --------------------------------------------------------------------
    - Objects not Strings
    - Piping output from commands
    
    New-Item -Name Test -ItemType Directory
    New-Item -Name Test\UsefulFile.txt -ItemType File

    Get-ChildItem 
    Get-ChildItem -Filter *Useful*
    Get-ChildItem -Filter *Useful* -Recurse
    Get-ChildItem -Recurse -Include *.txt
    Get-ChildItem -Path Tes* 
    Get-ChildItem -Path Tes* | Remove-Item

    '
    # Slide 4
    "
    PowerShell Basics - Services
    --------------------------------------------------------------------
    - Use PowerShell to monitor background services
    - Start or Stop services with PowerShell
    
    Get-Service
    Get-Service | Where-Object Status -eq 'Running'
    Start-Service -Name Fax
    Stop-Service -Name Fax
    "

    # Slide 5
    '
    PowerShell Basics - Processes
    --------------------------------------------------------------------
    - Let me tell you about my tab problem...

    Get-Process
    Get-Process | Out-GridView
    Get-Process | Out-GridView -Passthru | Stop-Process -Verbose

    Get-Process | Select-Object -First 5
    Get-Process | Sort-Object CPU -Descending | Select-Object -First 5
    '

    # Slide 6
    " 
    PowerShell Aliases
    --------------------------------------------------------------------
    - Alias = Alternative name
    - Helps bridge the gap between other shells and PowerShell
    - Don't use them in scripts!
    
    Get-ChildItem
    dir
    ls

    Set-Location
    cd 
    chdir

    Get-Alias
    Get-Alias | Get-Member
    Get-Alias | Where Definition -eq 'Get-Process'
    "

    # Slide 7
    '
    Modules
    --------------------------------------------------------------------
    - a self-contained, reusable container of scripts
    - write your own, or find an existing community module
    - PowerShell Gallery - Central repository for PowerShell Content

    Find-Module -Name dbatools
    Install-Module -Name dbatools
    Import-Module -Name dbatools
    '
    # Slide 8
    '
    Are my databases being backed up?
    --------------------------------------------------------------------
    - When was the last full backups for all SQL Servers
    - How long will it take to connect & check each one in SSMS?

    Get-Command -Name *backup*
    Find-DbaCommand -Pattern *backup*
    Get-Help
    '
    # Slide 9
    "
    /---------------------------------------------------\
    | " + "$($color.orange)`u{f796}$($color.reset) " * 25 + "|
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
    )
    cls
    
    # last slide popup feedback image
    if ($slide -eq $slides.count-1) {
        .\Demos\feedback.png
    }

    return $slides[$slide]
    
}

# Navigate forwared \ next
function n {
    param (
        [Parameter()]
        [int]$slideNumber
        )
        $global:SlideNum++
        
        Get-Slide -Slide $slideNum
    }
    
# Navigate back \ previous
function p {
    param (
        [Parameter()]
        [int]$slideNumber
    )
    $global:SlideNum--
    
    Get-Slide -Slide $slideNum
    
}

# init slidenum and start the party
$global:SlideNum = 0
Get-Slide -Slide $slideNum