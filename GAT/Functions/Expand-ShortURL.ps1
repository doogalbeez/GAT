Function Expand-ShortURL {
    Param(
        [Parameter(Mandatory = $true,HelpMessage = 'Short URL to be expanded',ValueFromPipeline = $True,Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string[]] $URL
    )

    Begin {}

    Process {
        ForEach ($Item in $URL) {
            Try {
                $Request = Invoke-WebRequest -Uri $Item -MaximumRedirection 0 -ErrorAction Ignore
                If ($Request.StatusCode -ge 300 -and $Request.StatusCode -lt 400) {
                    $LongURL = $Request.Headers.Location
                }

                [PSCustomObject]@{  
                    ShortURL = $Item
                    LongURL = $LongURL
                }
            } Catch {
                $_.Exception.Message
            }
        }            
    }

    End {}
}
