Import-Module ".\GenericMethods.psm1"
[System.Reflection.Assembly]::LoadFrom(".\lib\net46\DocumentFormat.OpenXml.dll") | out-null

[Reflection.Assembly]::LoadWithPartialName("DocumentFormat.OpenXml") | out-null
[Reflection.Assembly]::LoadWithPartialName("DocumentFormat.OpenXml.Packaging") | out-null
[Reflection.Assembly]::LoadWithPartialName("DocumentFormat.OpenXml.Wordprocessing") | out-null

$wordPath = ".\SampleOutput3.docx"

[DocumentFormat.OpenXml.Packaging.WordprocessingDocument]$doc = $null
$doc = [DocumentFormat.OpenXml.Packaging.WordprocessingDocument]::Open($wordPath, $true)

[DocumentFormat.OpenXml.Packaging.MainDocumentPart]$mainPart = $doc.MainDocumentPart

[DocumentFormat.OpenXml.Wordprocessing.Document]$innerDoc = $doc.Document

[DocumentFormat.OpenXml.Wordprocessing.Body]$body = $mainPart.Document.Body

[DocumentFormat.OpenXml.Wordprocessing.Paragraph]$paragraph = $null

$paragraphs = Invoke-GenericMethod -InputObject $mainPart.Document -MethodName Descendants -GenericType DocumentFormat.OpenXml.Wordprocessing.Paragraph

$paragraph = $paragraphs[0]

[DocumentFormat.OpenXml.Wordprocessing.Text]$text = Invoke-GenericMethod -InputObject $run -MethodName Descendants -GenericType DocumentFormat.OpenXml.Wordprocessing.Text
[DocumentFormat.OpenXml.Wordprocessing.Run]$run = Invoke-GenericMethod -InputObject $paragraph -MethodName Descendants -GenericType DocumentFormat.OpenXml.Wordprocessing.Run
$text.Text = "New Title"
$paragraph

$mainPart.Document.Save()
$doc.Close()
