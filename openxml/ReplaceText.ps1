Add-Type -Path ".\lib\net46\DocumentFormat.OpenXml.dll"
$templateWordPath = ".\OpenXmlTemplate.docx"
$wordPath = ".\SampleOutput3.docx"
$text = "New text added"
Copy-Item $templateWordPath -Destination $wordPath -Force

$myDoc = [DocumentFormat.OpenXml.Packaging.WordprocessingDocument]::Open($wordPath, $true)
$mainPart = $myDoc.MainDocumentPart
$body = $mainPart.Document.Body

$allElements = $mainPart.Document.Body.Elements()
    
$first = [Linq.Enumerable]::First($allElements)
$paraObj = New-Object -TypeName 'DocumentFormat.OpenXml.Wordprocessing.Paragraph'


[Func[string, bool]] $delegate = { param($d); return $d.InnerText -eq 'Document Title' }
$delegate = [Func[string, bool]] { $args[0] -eq 'Document Title' }

$text = [Linq.Enumerable]::First($first)


$text = $first.Descendants().Where({ $_.InnerText -eq 'Document Title' })

 
$para = $body.AppendChild($paraObj)
$runObj = New-Object -TypeName DocumentFormat.OpenXml.Wordprocessing.Run
$first.RemoveChild($runObj)
$run = $para.AppendChild($runObj)
$run.AppendChild((New-Object -TypeName DocumentFormat.OpenXml.Wordprocessing.Text -ArgumentList $text ))

## $text = $part.RootElement.Descendants<Text>().Where({ $_.Text -eq "a contract exclusively for construction work that is not building work." }).FirstOrDefault()

[Text] $text = (Select-Xml -Xml $first. -XPath "//Text[text()='Document Title']").Node.Value

$mainPart.Document.Save()
$myDoc.Close()