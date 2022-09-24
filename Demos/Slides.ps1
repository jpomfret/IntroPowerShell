Import-Module Pansies

# get rid of the test folder
if((Test-Path .\Test)){
    Remove-Item .\Test -Recurse -Force
}

# docker compose up some containers - using dev container now
# docker-compose -f .\Docker\docker-compose.yml up -d

function Get-Slide {#
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
    | " + "$($color.orange)`u{f109}$($color.reset) " * 28 + "|
    |                                                         |
    |        Introduction to PowerShell & dbatools            |
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
    Three commands to remember
    --------------------------------------------------------------------
    - If you remember nothing else, remember these!

      Get-Command
      Get-Help
      Get-Member

    Get-Command *Child*
    Get-Help Get-ChildItem -Full

    $file = Get-ChildItem .\Files\servers.csv
    $file
    $file | Get-Member
    $file.Extension
    $file.CopyTo("C:\GitHub\IntroPowerShell\Files\servers_backup.csv")
    Get-ChildItem .\Files\servers*

    '

    # Slide ? - Piping

    '
    | - The Pipeline
    --------------------------------------------------------------------
    - Adds a lot of the Power to PowerShell
    - Chain commands together
    - Passing output of the first command, through the | onto the next command

    $backupFile = Get-ChildItem C:\GitHub\IntroPowerShell\Files\servers_backup.csv
    $backupFile | Remove-Item
    Get-ChildItem C:\GitHub\IntroPowerShell\Files\servers*

    '

    # Slide ? - select
    '
    Select-Object - Select the properties you care about
    --------------------------------------------------------------------
    - Select-Object
    - Just like with T-SQL we don`t always want to select *!
    - Can also create calculated properties

    $file
    $file | Select-Object *
    $file | Select-Object Name, CreationTime, LastAccessTime, LastWriteTime
    $file | Select-Object Name, @{n=''SizeKB'';e={$_.Length/1KB}}
    $file | Select-Object Name, @{n=''SizeKB'';e={"{0:n2}" -f ($_.Length/1KB)}}

    '


    # Slide 5 - Where

    '
    Where-Object - Filter your results
    --------------------------------------------------------------------
    - This feels familiar - WHERE to filter results
    - For one comparison can write a comparison statement
    - For multiples we need a script block


    Get-ChildItem .\Files\Scripts
    Get-ChildItem .\Files\Scripts | Where-Object name -like ''ImportantScript*''
    Get-ChildItem .\Files\Scripts | Where-Object Extension -eq ''.md''

    Get-ChildItem .\Files\Scripts |
    Where-Object {$_.name -like ''ImportantScript*'' -and $_.IsReadOnly}

    '

    # Slide 5 - Sort

    '
    Sort-Object - Equivalent of ORDER BY
    --------------------------------------------------------------------
    - More similarities to T-SQL
    - Order the outputted results

    Get-ChildItem .\Files\Scripts | Sort-Object LastWriteTime
    Get-ChildItem .\Files\Scripts | Sort-Object LastWriteTime -Desc

    '


    # Slide ? - Select + Where + Sort

    '
    Multiple Pipelines
    --------------------------------------------------------------------
    - We''re not restricted to one pipeline

    Get-ChildItem .\Files\Scripts |
    Where-Object name -like ''ImportantScript*'' |
    Sort-Object LastWriteTime -Desc |
    Select-Object Name, LastWriteTime, @{n=''SizeKB'';e={"{0:n2}" -f ($_.Length/1KB)}}

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
    gci
    ls

    Set-Location
    cd
    chdir
    sl

    Get-Alias
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
    Get-Module -Name dbatools -ListAvailable
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

    # Slide 8
    '
    Test and Set Database Owners
    --------------------------------------------------------------------
    - DBAs often change the database owner to a standard account across the estate
    - How do you keep track of any databases with different owners?
    - How do you easily change database owners?

    Test-DbaDbOwner -SqlInstance $mssql1, $mssql2 |
    Select-Object SqlInstance, Database, CurrentOwner, TargetOwner, OwnerMatch |
    Format-Table

    Set-DbaDbOwner -SqlInstance  $mssql1, $mssql2 -TargetLogin sa
    '

    # Slide 8
    '
    Are all our SQL instances patched to the latest version?
    ---------------------------------------------------------------------
    - Keeping up to date with SQL patches is another important DBA task
    - Online version: https://dbatools.io/build

    Get-DbaBuild -SqlInstance $mssql1, $mssql2

    Test-DbaBuild -SqlInstance  $mssql1, $mssql2 -Latest
    Test-DbaBuild -SqlInstance  $mssql1, $mssql2 -MaxBehind 1CU

    '

    # Slide 8
    '
    Remember
    ---------------------------------------------------------------------
    - If you remember nothing else, remember these!

      Get-Command
      Get-Help
      Get-Member

    '

    # Slide 8
    '
    Next Steps
    ---------------------------------------------------------------------
    - To continue the learning

    - Watch the rest of the PowerShell Learning Pathway
        - Introduction to PowerShell & dbatools - Jess Pomfret
        - Simplifying Encryption and Migrations using dbatools - Chrissy LeMaire
        - Using dbachecks to Validate your SQL Server Estate - Tracy Boggiano
        - Using Dev Containers to Test your Scripts - Rob Sewell

    - Get the book!
        ''Learn dbatools in a Month of Lunches''
        https://dbatools.io/book

    '

    # next steps
    <#
    - book
    - rest of the pathway

    #>

<#

- updating database owners for multiple instances at once
- confirming our SQL instances are patched to the latest version.

#>

    # Slide 9
    "
    /---------------------------------------------------\
    | " + "$($color.orange)`u{f109}$($color.reset) " * 25 + "|
    |                                                   |
    |        Thanks for joining me!                     |
    |                                                   |
    |        Back to the pptx -->                       |
    |                                                   |
    |                                                   |
    |                                                   |
    |                        $($color.orange)`u{f408}$($color.reset) jpomfret/IntroPowerShell |
    |                        $($color.orange)`u{f6ef}$($color.reset) jpomfret7@gmail.com      |
    |                        $($color.orange)`u{f099}$($color.reset) @jpomfret                |
    \---------------------------------------------------/
    "
    )
    Clear-Host

    # last slide popup feedback image
    #if ($slide -eq $slides.count-1) {
    #    .\Demos\feedback.png
    #}

    return $slides[$slide]

}

# Navigate forward \ next
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

# init slideNum and start the party
$global:SlideNum = 0
Get-Slide -Slide $slideNum




<#


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
    Get-Process | Out-GridView -PassThru | Stop-Process -Verbose

    Get-Process | Select-Object -First 5
    Get-Process | Sort-Object CPU -Descending | Select-Object -First 5
    '


    #>