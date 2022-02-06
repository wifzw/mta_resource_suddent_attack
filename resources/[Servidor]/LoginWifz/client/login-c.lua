local largura,altura = guiGetScreenSize()

addEventHandler("onClientRender", root, function()
    outputDebugString(largura)
    outputDebugString(altura)
    --dxDrawRectangle(
    --        largura / 2 - 200 / 2,
    --        altura / 2 - 200 / 2,
    --        200,
    --        200,
    --        toColor(23,23,25)
    --)
end)