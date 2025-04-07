# Dieses Skript listet alle Dateien und Verzeichnisse im angegebenen Verzeichnis auf.
# Es kann verwendet werden, um die Inhalte eines Verzeichnisses schnell anzuzeigen.



# Dateipfad des gewünschten Verzeichnisses festlegen (bei Bedarf anpassen)
$DirectoryPath = $(git rev-parse --show-toplevel) # Ermittelt das oberste Verzeichnis des Git-Repositories

# Inhalte des angegebenen Verzeichnisses abrufen
# $Contents = Get-ChildItem -Path $DirectoryPath -Recurse -File | Select-Object Name, FullName, Length, LastWriteTime


# ...existing code...

# Inhalte mit einer foreach-Schleife ausgeben
foreach ($Item in $Contents)
{
    Write-Output "Name: $($Item.Name)"
    Write-Output "Vollständiger Name: $($Item.FullName)"
    Write-Output "Größe (Bytes): $($Item.Length)"
    Write-Output "Zuletzt geändert: $($Item.LastWriteTime)"
    Write-Output "----------------------------------------"
} # end foreach

# Inhalte mithilfe einer Pipeline ausgeben
