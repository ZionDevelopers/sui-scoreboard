local PANEL = {}

--- Init
function PANEL:Init()
	self.pnlCanvas 	= vgui.Create( "Panel", self )
	self.YOffset = 0
end

--- GetCanvas
function PANEL:GetCanvas()

	return self.pnlCanvas

end

--- OnMouseWheeled
function PANEL:OnMouseWheeled( dlta )

	local MaxOffset = self.pnlCanvas:GetTall() - self:GetTall()
	if MaxOffset > 0 then	
		self.YOffset = math.Clamp( self.YOffset + dlta * -100, 0, MaxOffset )		
	else		
		self.YOffset = 0	
	end
	
	self:InvalidateLayout()	
end

--- PerformLayout

function PANEL:PerformLayout()
	self.pnlCanvas:SetPos( 0, self.YOffset * -1 )
	self.pnlCanvas:SetSize( self:GetWide(), self.pnlCanvas:GetTall() )
end

vgui.Register( "suiplayerframe", PANEL, "Panel" )