<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucServiceTax.ascx.cs" Inherits="WebX.CommonControls.ucServiceTax" %>
<%@ Import Namespace="WebX.Common" %>
<script type="text/javascript" src="<%= ResolveUrl("~/GUI/Common_UserControls/Js/ServiceTax.js") %>"></script>
<script type="text/javascript">
    var uclblServiceTaxRate, uclblEducationCessRate, uclblHigherEducationCessRate, uclblSBCessRate, uclblKKCessRate,
        uchdnServiceTaxRateApplied, uchdnEducationCessRateApplied, uchdnHigherEducationCessRateApplied, uchdnSBCessRateApplied, uchdnKKCessRateApplied,
        uchdnServiceTaxRate, uchdnEducationCessRate, uchdnHigherEducationCessRate, uchdnSBCessRate, uchdnKKCessRate,
        uctxtSubTotal, uctxtServiceTax, uctxtEducationCess, uctxtHigherEducationCess, uctxtSBCess, uctxtKKCess, uctxtGrandTotal,
        uchdnSubTotal, uchdnServiceTax, uchdnEducationCess, uchdnHigherEducationCess, uchdnSBCess, uchdnKKCess, uchdnGrandTotal,
        uchdnIsRoundOffRequired, uchdnIsServiceTaxExempted, uchdnServiceTaxPayer, uchdnExceedAmount, uchdnTransportMode,
        uchdnTransactionDate, uchdnServiceType, uchdnIsRebateApplicable, uchdnCheckExceedAmount;
    var serviceUrl;
    $(document).ready(function () {
        LoadControl("<%=txtSubTotal.ClientID%>");
        serviceUrl = "<%= ResolveUrl("~/GUI/services/WebService.asmx") %>";
    });
</script>
<table class="boxbg" cellspacing="1" style="width:100%;">
    <tr class="nrow">
        <td>
            <asp:HiddenField ID="hdnTransactionDate" runat="server" Value="" />
            <asp:HiddenField ID="hdnIsRoundOffRequired" runat="server" Value="N" />
            <asp:HiddenField ID="hdnExceedAmount" runat="server" Value="0" />
            <asp:HiddenField ID="hdnTransportMode" runat="server" Value="2" />
        </td>
        <td>
            <asp:HiddenField ID="hdnIsServiceTaxExempted" runat="server" Value="N" />
            <asp:HiddenField ID="hdnServiceTaxPayer" runat="server" Value="T" />
            <asp:HiddenField ID="hdnServiceType" runat="server" Value="1" />
            <asp:HiddenField ID="hdnIsRebateApplicable" runat="server" Value="N" />
            <asp:HiddenField ID="hdnCheckExceedAmount" runat="server" Value="N" />
        </td>
        <td>
            <b>Sub Total</b></td>
        <td>
            <asp:TextBox ID="txtSubTotal" runat="server" CssClass="input-small rtxt" MaxLength="10" Width="80px"
                onkeypress="javascript:return validFloat(event,this.getAttribute('id'))">
            </asp:TextBox>
            <asp:HiddenField id="hdnSubTotal"  runat="server"/> 
        </td>
    </tr>
    <tr class="nrow">
        <td>Service Tax Rate (%)</td>
        <td>
            <asp:Label ID="lblServiceTaxRate" runat="server" CssClass="nfnt"></asp:Label>
            <asp:HiddenField ID="hdnServiceTaxRateApplied" runat="server"></asp:HiddenField>
            <asp:HiddenField ID="hdnServiceTaxRate" runat="server"></asp:HiddenField>
        </td>
        <td>Service Tax on Sub Total</td>
        <td>
            <asp:TextBox ID="txtServiceTax" Enabled="false" runat="server" CssClass="input-small rtxt" MaxLength="10" Width="80px"
                onkeypress="javascript:return validFloat(event,this.getAttribute('id'))">
            </asp:TextBox>
             <asp:HiddenField id="hdnServiceTax"  runat="server"/> 
        </td>
    </tr>
    <tr class="nrow">
        <td>Educational Cess Rate (%)</td>
        <td>
            <asp:Label ID="lblEducationCessRate" runat="server" CssClass="nfnt"></asp:Label>
            <asp:HiddenField ID="hdnEducationCessRateApplied" runat="server"></asp:HiddenField>
            <asp:HiddenField ID="hdnEducationCessRate" runat="server"></asp:HiddenField>
        </td>
        <td>Educational Cess on Service Tax</td>
        <td>
            <asp:TextBox ID="txtEducationCess" Enabled="false" runat="server" CssClass="input-small rtxt" MaxLength="10" Width="80px"
                onkeypress="javascript:return validFloat(event,this.getAttribute('id'))">
            </asp:TextBox>
              <asp:HiddenField id="hdnEducationCess"  runat="server"/> 
        </td>
    </tr>
    <tr class="nrow">
        <td>Higher Educational Cess Rate (%)</td>
        <td>
            <asp:Label ID="lblHigherEducationCessRate" runat="server" CssClass="nfnt"></asp:Label>
            <asp:HiddenField ID="hdnHigherEducationCessRateApplied" runat="server"></asp:HiddenField>
            <asp:HiddenField ID="hdnHigherEducationCessRate" runat="server"></asp:HiddenField>
        </td>
        <td>Higher Educational Cess on Service Tax</td>
        <td>
            <asp:TextBox ID="txtHigherEducationCess" runat="server" CssClass="input-small rtxt" Enabled="false" MaxLength="10" Width="80px"
                onkeypress="javascript:return validFloat(event,this.getAttribute('id'))">
            </asp:TextBox>
             <asp:HiddenField id="hdnHigherEducationCess"  runat="server"/> 
        </td>
    </tr>
    <tr class="nrow">
        <td><%=SBCessCaption %> Rate (%)</td>
        <td>
            <asp:Label ID="lblSBCessRate" runat="server" CssClass="nfnt"></asp:Label>
            <asp:HiddenField ID="hdnSBCessRateApplied" runat="server"></asp:HiddenField>
            <asp:HiddenField ID="hdnSBCessRate" runat="server"></asp:HiddenField>
        </td>
        <td><%=SBCessCaption %> on Sub Total</td>
        <td>
            <asp:TextBox ID="txtSBCess" Enabled="false" runat="server" CssClass="input-small rtxt" Width="80px"
                onkeypress="javascript:return validFloat(event,this.getAttribute('id'))">
            </asp:TextBox>
            <asp:HiddenField id="hdnSBCess"  runat="server"/> 
        </td>
    </tr>
    <tr class="nrow">
        <td><%=KKCessCaption %> Rate (%)</td>
        <td>
            <asp:Label ID="lblKKCessRate" runat="server" CssClass="nfnt"></asp:Label>
            <asp:HiddenField ID="hdnKKCessRateApplied" runat="server"></asp:HiddenField>
            <asp:HiddenField ID="hdnKKCessRate" runat="server"></asp:HiddenField>
        </td>
        <td><%=KKCessCaption %> on Sub Total</td>
        <td>
            <asp:TextBox ID="txtKKCess" Enabled="false" runat="server" CssClass="input-small rtxt" Width="80px"
                onkeypress="javascript:return validFloat(event,this.getAttribute('id'))">
            </asp:TextBox>
             <asp:HiddenField id="hdnKKCess"  runat="server"/> 
        </td>
    </tr>
    <tr class="nrow">
        <td>&nbsp;</td>
        <td></td>
        <td>
            <asp:Label ID="lblGrandTotal" runat="server" CssClass="nfnt" Text="Grand Total" Font-Bold="true"></asp:Label></td>
        <td>
            <asp:TextBox ID="txtGrandTotal" runat="server" CssClass="input-small rtxt" MaxLength="10" Width="80px"
                onkeypress="javascript:return validFloat(event,this.getAttribute('id'))">
            </asp:TextBox>
        <asp:HiddenField id="hdnGrandTotal"  runat="server"/> 
        </td>
    </tr>
</table>
