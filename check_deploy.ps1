try {
    $r = Invoke-WebRequest -Uri "https://200remedioscaseros.vercel.app/landingremediosv2" -UseBasicParsing
    Write-Host "STATUS:" $r.StatusCode
    Write-Host "LENGTH:" $r.Content.Length
    Write-Host "CONTAINS_INDEX:" ($r.Content.Contains("¿Cuál es tu problema? Tocá el tuyo"))
    Write-Host "CONTAINS_MOCKUP:" ($r.Content.Contains("book-3d"))
    Write-Host "CONTAINS_REVIEWS:" ($r.Content.Contains("Rosa Elena Rivas"))
} catch {
    Write-Host "ERROR:" $_
}
