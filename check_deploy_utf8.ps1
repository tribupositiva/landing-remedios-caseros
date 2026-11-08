$r = Invoke-WebRequest -Uri "https://200remedioscaseros.vercel.app/landingremediosv2" -UseBasicParsing
Write-Host "Contains prob-grid:" ($r.Content.IndexOf("prob-grid") -ge 0)
Write-Host "Contains prob-panel:" ($r.Content.IndexOf("prob-panel") -ge 0)
Write-Host "Contains book-3d:" ($r.Content.IndexOf("book-3d") -ge 0)
Write-Host "Contains Rosa Elena:" ($r.Content.IndexOf("Elena") -ge 0)
Write-Host "Contains Sofia M.:" ($r.Content.IndexOf("Sofia") -ge 0)
Write-Host "Contains Dificultad para dormir:" ($r.Content.IndexOf("para dormir") -ge 0)
