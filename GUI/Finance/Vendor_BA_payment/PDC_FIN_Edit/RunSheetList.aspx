<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="RunSheetList.aspx.cs" Inherits="GUI_Operation_Finance_Vendor_BA_payment_PrepareVoucher_RunSheet_RunSheetList" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script  language="javascript" type="text/javascript">

function CheckDocketSelection(txtdocketlist,txtdocketlist_count)
        {
            //Get count of records fetched
           
            var mTotalRecords = "<%=intTotalRecords %>"
           
            var mDerivedControlName = "";
            var mSelection = 0;
            var j = 0;
            var mSelectedDockets = "";
              // alert(mTotalRecords)
            for (var i=0; i < mTotalRecords; i++)
            {
                j = i + 2;
            
                if(j < 10)
                {
                
                    mDerivedControlName = "ctl00$MyCPH1$gvpdclist$ctl" + "0" + j + "$chkyes"
                  
                }
                else
                {
                    mDerivedControlName = "ctl00$MyCPH1$gvpdclist$ctl" + j + "$chkyes"
                    
                }
                
                if(document.getElementById(mDerivedControlName))
                {
                    if(document.getElementById(mDerivedControlName).checked == true)
                    {
                        if(mSelection == 0)
                        {
                            mSelection = 1;
                        }
                        mSelectedDockets = (mSelectedDockets == "" ? document.getElementById(mDerivedControlName).value : mSelectedDockets + "," + document.getElementById(mDerivedControlName).value);
                    }
                }
            }
            
            if(mSelection == 0)
            {
                alert("Select atleast one Document ....!");
                
                return false;
            }

            txtdocketlist.value=mSelection
            txtdocketlist_count.value=mSelectedDockets;
         
            
            return true;
        }



 function popupmenu2(choice)
 { 
  var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
  confirmWin=window.open(choice,"",winOpts);
 }
 </script>

<p>&nbsp;</p>

                                  <%--Back Link To First Page in Viewing Agent Bills--%>
    
 <div align="center" style="width:9.5in">
                                
<table width="100%">
        <tr>
            <td align="center"><font class="blackfnt"> You Selected</font></td>
        </tr>
</table>
<br />
                      <%--      SELECTION CRITERIA--%>

        <table align="center" bgcolor="#808080" class="boxbg" cellpadding="3" cellspacing="1" style="width:6in;">
            <tr id="trdocno" visible="false" runat="server" bgcolor="#ffffff" class="blackfnt">
                <td align="left" style="width:50%">Document Number </td>
                <td align="left" bgcolor="#ffffff" style="width:50%">
                    <asp:Label runat="server" ID="lbldocno"></asp:Label>
                </td>
            </tr>
          <tr id="trmanno" visible="false" runat="server" bgcolor="#ffffff" class="blackfnt">
                <td align="left" style="width:50%"> Manual PDC Number </td>
                <td align="left" bgcolor="#ffffff" style="width:50%">
                    <asp:Label runat="server" ID="lblmanpdcno"></asp:Label>
                </td>
            </tr>
            <tr id="trvehno" visible="false" runat="server" bgcolor="#ffffff" class="blackfnt">
                <td align="left" style="width:50%"> Vehicle Number </td>
                <td align="left" bgcolor="#ffffff" style="width:50%">
                    <asp:Label runat="server" ID="lblvehno"></asp:Label>
                </td>
            </tr>
            <tr id="trdates" visible="false" runat="server" bgcolor="#ffffff" class="blackfnt">
                <td align="left" style="width:50%"> Dates </td>
                <td align="left" bgcolor="#ffffff" style="width:50%">
                    <asp:Label runat="server" ID="lbldates"></asp:Label>
                </td>
            </tr>

        </table>
        
<br />
                                                         <%--GRID VIEW OF DATA--%>
           
            <asp:GridView align="center" ID="gvpdclist"  BorderWidth="0" runat="server" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey"
                AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"
                CssClass="boxbg" FooterStyle-CssClass="boxbg"
                PagerSettings-Mode="NumericFirstLast" HeaderStyle-Height="24px" AutoGenerateColumns="false"
                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange"
                OnSelectedIndexChanged="gvpdclist_SelectedIndexChanged"  Width="90%">
<Columns >
 
       <%-- <asp:TemplateField HeaderText="Sr.No." >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Right" />
                    <ItemTemplate>
                      <asp:CheckBox ID="chkyes" runat="server" />
                        <input type="checkbox" id="chkyes" runat="server" class="input" value='<%# DataBinder.Eval(Container.DataItem,"pdcno") %>' />
                </ItemTemplate>
        </asp:TemplateField>--%>


    <asp:TemplateField HeaderText="PDC Number" SortExpression="tot1">
        <HeaderStyle CssClass = "blackfnt" />
            <ItemStyle Font-Underline="true" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
            <ItemTemplate>
                <asp:LinkButton ID="lnkid" Text='<%# DataBinder.Eval( Container.DataItem,"pdcno") %>' runat="server">
                    <a href="javascript:popupmenu2('.aspx?billno=<%# DataBinder.Eval( Container.DataItem,"pdcno") %>&printyn=0')" > <%# DataBinder.Eval( Container.DataItem,"pdcno") %> </a>
                </asp:LinkButton>
            </ItemTemplate>
    </asp:TemplateField>

        <asp:BoundField DataField="prs_drs" HeaderText="PDC Date" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
        </asp:BoundField>


        <asp:BoundField DataField="pdcbrstr" HeaderText="PDC Branch" >
             <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle BackColor="white" CssClass="blackfnt"  HorizontalAlign="Center"  />
        </asp:BoundField>

        <asp:BoundField DataField="strba" HeaderText="Vendor" >
             <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle BackColor="white" CssClass="blackfnt"  HorizontalAlign="Center"  />
        </asp:BoundField>

        <asp:BoundField DataField="vehno" HeaderText="Vehicle Number" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
        </asp:BoundField>
        <asp:TemplateField HeaderText="Edit" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemTemplate>
                      <a href="PDC_FIN_Updates.aspx?<%# DataBinder.Eval( Container.DataItem,"pdcno") %>">Edit</a>
                </ItemTemplate>
        </asp:TemplateField>

</Columns>
<PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
<HeaderStyle CssClass="bgbluegrey" />
<PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
/>
<FooterStyle CssClass="boxbg" />
</asp:GridView>

<asp:Table ID="tblgrid" runat="server" CellSpacing="1" CssClass="boxbg" style="width:90%;" Visible="false">
    <asp:TableRow CssClass="bgbluegrey" style="height:20px;">
        <asp:TableCell HorizontalAlign="Center" CssClass="blackfnt">PDC Number </asp:TableCell>
        <asp:TableCell HorizontalAlign="Center" CssClass="blackfnt">PDC Date </asp:TableCell>
        <asp:TableCell HorizontalAlign="Center" CssClass="blackfnt">PDC Branch </asp:TableCell>
        <asp:TableCell HorizontalAlign="Center" CssClass="blackfnt">Vendor </asp:TableCell>
        <asp:TableCell HorizontalAlign="Center" CssClass="blackfnt">Vehicle Number </asp:TableCell>
    </asp:TableRow>
    <asp:TableRow BackColor="White" style="height:20px;">
        <asp:TableCell CssClass="redfnt" ColumnSpan="5">
            No Records Found.....
        </asp:TableCell>
    </asp:TableRow>
</asp:Table>

<br />

  <table style="width:90%" id="tblsubmit" runat="server" class="boxbg" cellspacing="1">
               <%-- <tr class="bgbluegrey">
                    <td align="center">
                    <asp:HiddenField ID="txtdocketlist" runat="server" />
       <asp:HiddenField ID="txtdocketlist_count" runat="server" />
                    
                      <%--  <asp:Button ID="btnsubmit1" runat="server" Text="Submit" OnClick="btnsubmit_Click" />   --%>        
                    <%--</td>
                </tr>--%>
           </table>

</div>
</asp:Content>
