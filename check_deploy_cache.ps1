try {
    $ts = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
    $url = "https://200remedioscaseros.vercel.app/landingremediosv2?t=$ts"
    $r = Invoke-WebRequest -Uri $url -Headers @{ "Cache-Control" = "no-cache" } -UseBasicParsing
    Write-Host "URL:" $url
    Write-Host "STATUS:" $r.StatusCode
    Write-Host "LENGTH:" $r.Content.Length
    Write-Host "CONTAINS_INDEX:" ($r.Content.Contains("¿Cuál es tu problema? Tocá el tuyo"))
    Write-Host "CONTAINS_MOCKUP:" ($r.Content.Contains("book-3d"))
    Write-Host "CONTAINS_REVIEWS:" ($r.Content.Contains("Rosa Elena Rivas"))
} catch {
    Write-Host "ERROR:" $_
}
