Add-Type -Path ".\lib\net46\DocumentFormat.OpenXml.dll"
$templateWordPath = ".\OpenXmlTemplate.docx"
$wordPath = ".\SampleOutput2.docx"
$text = "New text added"
Copy-Item $templateWordPath -Destination $wordPath -Force

$myDoc = [DocumentFormat.OpenXml.Packaging.WordprocessingDocument]::Open($wordPath, $true)
$mainPart = $myDoc.MainDocumentPart;
$body = $mainPart.Document.Body

$paraObj = New-Object -TypeName 'DocumentFormat.OpenXml.Wordprocessing.Paragraph' 
$para = $body.AppendChild($paraObj)
$runObj = New-Object -TypeName DocumentFormat.OpenXml.Wordprocessing.Run

$run = $para.AppendChild($runObj)
$run.AppendChild((New-Object -TypeName DocumentFormat.OpenXml.Wordprocessing.Text -ArgumentList $text ))

$mainPart.Document.Save()
$myDoc.Close()