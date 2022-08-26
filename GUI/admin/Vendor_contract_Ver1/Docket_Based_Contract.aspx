<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Docket_Based_Contract.aspx.cs" Inherits="GUI_admin_Vendor_contract_Ver1_Docket_Based_Contract" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="Vendor_Contract.js"></script>
    <script type="text/javascript" language="javascript">
        var controlIdPrefix="ctl00_MyCPH1_";
        
        function openPopupLoc(ctrlId) 
        {
            window.open("frm_Popup_Location.aspx?CtrlID="+ctrlId, null, "height=300,width=400,left=300,top=200,status=no,resizable=yes,scrollbars=yes,toolbar=no,location=no,menubar=no");
        }
        function openPopupCity(ctrlId) 
        {
            window.open("frm_Popup_City.aspx?CtrlID="+ctrlId, null, "height=300,width=400,left=300,top=200,status=no,resizable=yes,scrollbars=yes,toolbar=no,location=no,menubar=no");
        }
        
        function checkOnSubmit()
        {             
            var grid =  document.getElementById(controlIdPrefix+"GV_Docket_Matrix");
            var len=parseInt(grid.rows.length);
            var pref="";
            var cnt=0;
                       
            for (var i = 2; i <= grid.rows.length; i++)
            {
                var str_Index="";
                if (i < 10) str_Index = "0" + i; else str_Index = i;
                
                pref = controlIdPrefix + "GV_Docket_Matrix_ctl" + str_Index + "_";               
                
                var ChkInd = document.getElementById(pref+"ChkInd");
                var Ddl_Mode = document.getElementById(pref+"Ddl_Mode");
                var Ddl_Paybas = document.getElementById(pref+"Ddl_Paybas");
                var Ddl_Bkg_Del = document.getElementById(pref+"Ddl_Bkg_Del");
                var Ddl_Rate_Type = document.getElementById(pref+"Ddl_Rate_Type");
                
                var Txt_Location = document.getElementById(pref+"Txt_Location");
                var Txt_City = document.getElementById(pref+"Txt_City");
                var Txt_MinChg = document.getElementById(pref+"Txt_MinChg");                
                var Txt_Rate = document.getElementById(pref+"Txt_Rate");
                var Txt_MaxChg = document.getElementById(pref+"Txt_MaxChg");
                
                if(ChkInd.checked==true)
                {
                    cnt++;
                    if(Txt_City.value=="")
                    {
                        alert("Please Select From City");
                        Txt_City.focus();
                        return false;
                    }
                    
                    if(Txt_Location.value=="")
                    {
                        alert("Please Select Location");
                        Txt_Location.focus();
                        return false;
                    }
                    
                    if(Ddl_Mode.value=="")
                    {
                        alert("Please Select Mode");
                        Ddl_Mode.focus();
                        return false;
                    }
                    if(Ddl_Paybas.value=="")
                    {
                        alert("Please Select From Payment Basis");
                        Ddl_Paybas.focus();
                        return false;
                    }                    
                    if(Ddl_Bkg_Del.value=="")
                    {
                        //alert("Please Select Booking/Delivery");
                        //Ddl_Bkg_Del.focus();
                        //return false;
                    }
                   
                    if(Txt_MinChg.value=="")
                    {
                        alert("Please Enter Min. Chg/Cnote");
                        Txt_MinChg.focus();
                        return false;
                    }
                    if(Ddl_Rate_Type.value=="")
                    {
                        alert("Please Select Rate Type");
                        Ddl_Rate_Type.focus();
                        return false;
                    }
                    if(Txt_Rate.value=="")
                    {
                        alert("Please Enter Rate");
                        Txt_Rate.focus();
                        return false;
                    }
                    if(Txt_MaxChg.value=="")
                    {
                        alert("Please Enter Max. Chg./Cnote");
                        Txt_MaxChg.focus();
                        return false;
                    }
                    
                    for(var j = 2; j < len; j++)
                    {
                        var jref="";
                        var str_jIndex="";
                        
                        if (j < 10) str_jIndex = "0" + j; else str_jIndex = j;
                        
                        jref = controlIdPrefix + "GV_Docket_Matrix_ctl" + str_jIndex + "_"; 
                      
                        if(i!=j)
                        {
                           var jTxt_Location = document.getElementById(jref+"Txt_Location");
                           var jTxt_City = document.getElementById(jref+"Txt_City");
                           var jDdl_Mode = document.getElementById(jref+"Ddl_Mode");
                           var jDdl_Paybas = document.getElementById(jref+"Ddl_Paybas");
                           var jDdl_Bkg_Del = document.getElementById(jref+"Ddl_Bkg_Del");
                           var jDdl_Rate_Type = document.getElementById(jref+"Ddl_Rate_Type");
                           
                           if(jTxt_Location.value != "" && jTxt_City.value != "" && jDdl_Mode.value != "" && jDdl_Paybas.value != "")
                           {
                               if(jTxt_Location.value==Txt_Location.value && jTxt_City.value==Txt_City.value && jDdl_Mode.value==Ddl_Mode.value && jDdl_Paybas.value==Ddl_Paybas.value)
                               {
                                    alert("Record Already Exist. Please Select Another Location, City, Mode or Paybase");                                    
                                    jTxt_Location.focus();
                                    return false;
                               }
                           }                            
                        } // i!=j
                        
                    } //  J loop
                
                } // Check of YES/NO        

            } // I loop   
            if(cnt==0)
            {
                alert("No Record Selected To Save.");
                return false;                    
            }
            else
                return true;
        }
    </script>
    <div>
        <asp:UpdatePanel ID="upd1" runat="server">
            <ContentTemplate>
                <table>
                    <tr>
                        <td>
                            <br />
                            <table border="0" style="width: 5.0in" align="left" cellpadding="5" cellspacing="1"
                                class="boxbg">
                                <tr bgcolor="#ffffff">
                                    <td class="bgbluegrey" colspan="2" align="Left">
                                        <asp:Label ID="Lbl_Contract_title" Text="Vendor Contract Step 2:Cnote Based Contract"
                                            runat="server" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td colspan="2" align="Left">
                                        <asp:Label ID="Lbl_ADD_Edit" runat="server" CssClass="bluefnt" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td align="Left">
                                        Vendor Type:
                                    </td>
                                    <td align="Left">
                                        <asp:Label ID="Lbl_VendorType" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td align="Left">
                                        Vendor Code & Name:
                                    </td>
                                    <td align="Left">
                                        <asp:Label ID="Lbl_Vendor" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                            <table border="0" style="width: 8.0in" align="left" cellpadding="5" cellspacing="1"
                                class="boxbg">
                                <tr bgcolor="#ffffff">
                                    <td class="bgbluegrey" colspan="2" align="Left">
                                        <asp:Label ID="Lbl_Contract_title2" Text="CN Based Contract Matrix : Booking Charges" runat="server" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td align="Left">
                                        <font class="blackfnt">Enter No. Of Rows</font>
                                    </td>
                                    <td align="Left">
                                        <asp:TextBox ID="Txt_TotRows" runat="server" Text="1" CssClass="blackfnt" BorderStyle="Groove"
                                            Width="60" Style="text-align: right" onkeypress="javascript:return validInt(event)"></asp:TextBox>
                                        <asp:Button ID="Btn_AddRow" OnClick="AddGridRow" runat="server" CssClass="blackfnt"
                                            Text="Add ROW" UseSubmitBehavior="False" />
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td align="Left" colspan="2">
                                        <asp:GridView Visible="true" align="left" ID="GV_Docket_Matrix" runat="server" BorderWidth="0"
                                         Width="100%"
                                            CellPadding="5" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="false"
                                            AllowPaging="false" CssClass="boxbg" AutoGenerateColumns="false" FooterStyle-CssClass="boxbg"
                                            OnRowDataBound="GV_Route_Matrix_RowDataBound" EmptyDataText="No Records Found...">
                                            <Columns>
                                                <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white" ItemStyle-Wrap="false" >
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="ChkAll" runat="server" onclick="javascript:Check_All('GV_Docket_Matrix','ChkAll','ChkInd','N')" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                                            runat="server">
                                                        </asp:Label>
                                                        <asp:CheckBox ID="ChkInd" runat="server" onclick="javascript:Check_Ind('GV_Docket_Matrix','ChkAll','ChkInd')" />
                                                        <asp:HiddenField ID="hidID" runat="server" Value="0"/>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="From City" ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="Txt_City" Text="" runat="server" CssClass="blackfnt" BorderStyle="Groove" MaxLength="8"
                                                            Width="80" ></asp:TextBox>
                                                        <input type="button" value="..." runat="server"  class="blackfnt" BorderStyle="Groove" id="btnCity" />
                                                        <ajaxToolkit:AutoCompleteExtender ID="extCity" runat="server"  MinimumPrefixLength="1" ServiceMethod="GetCityList"
                                                                ServicePath="../../services/WebService.asmx" TargetControlID="Txt_City" >
                                                        </ajaxToolkit:AutoCompleteExtender>                                                                                       
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" Wrap="false"/>
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Location" ItemStyle-BackColor="white" >
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="Txt_Location" Text="" runat="server" CssClass="blackfnt" BorderStyle="Groove" MaxLength="8"
                                                            Width="80" ></asp:TextBox>
                                                        <input type="button" value="..." runat="server"  class="blackfnt" BorderStyle="Groove" id="btnLoc" />
                                                        <ajaxToolkit:AutoCompleteExtender ID="extLocation" runat="server"  MinimumPrefixLength="1" ServiceMethod="GetLocationList"
                                                                ServicePath="../../services/WebService.asmx" TargetControlID="Txt_Location" >
                                                        </ajaxToolkit:AutoCompleteExtender>                                                                                   
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" Wrap="false"/>
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>                                                
                                                <asp:TemplateField HeaderText="Pay Basis" ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="Ddl_Paybas" runat="server" CssClass="blackfnt">
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Mode" ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="Ddl_Mode" runat="server" CssClass="blackfnt">
                                                        </asp:DropDownList>
                                                        
                                                        <asp:DropDownList ID="Ddl_Bkg_Del" runat="server" CssClass="blackfnt" style="display:none;">
                                                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                                        <asp:ListItem Text="Booking" Value="B" Selected="true"></asp:ListItem>
                                                        <asp:ListItem Text="Delivery" Value="D"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                <%--<asp:TemplateField HeaderText="Booking/Delivery" ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="Ddl_Bkg_Del" runat="server" CssClass="blackfnt">
                                                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                                        <asp:ListItem Text="Booking" Value="B" Selected="true"></asp:ListItem>
                                                        <asp:ListItem Text="Delivery" Value="D"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>--%>
                                                <asp:TemplateField HeaderText="Min. Chg/Cnote" ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="Txt_MinChg" Text="0.00" runat="server" CssClass="blackfnt" BorderStyle="Groove" MaxLength="12"
                                                            Width="80" Style="text-align: right" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Rate Type" ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="Ddl_Rate_Type" runat="server" CssClass="blackfnt">
                                                            <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                                            <asp:ListItem Text="Per Kg" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="Per Package" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="% of sub-total of Cnote" Value="3"></asp:ListItem>
                                                            <asp:ListItem Text="% of basic freight of Cnote" Value="4"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                 <asp:TemplateField HeaderText="Rate/Cnote" ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="Txt_Rate" Text="0.00" runat="server" CssClass="blackfnt" BorderStyle="Groove" MaxLength="8"
                                                            Width="80" Style="text-align: right" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Max. Chg./Cnote" ItemStyle-BackColor="white">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="Txt_MaxChg" Text="0.00" runat="server" CssClass="blackfnt" BorderStyle="Groove" MaxLength="12"
                                                            Width="80" Style="text-align: right" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                               
                                            </Columns>
                                            <RowStyle HorizontalAlign="center" BackColor="white" CssClass="blackfnt" Wrap="false"
                                                  />
                                            <PagerStyle HorizontalAlign="left" Font-Bold="true" CssClass="bgbluegrey" />
                                            <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]"
                                                Mode="NumericFirstLast" />
                                            <FooterStyle CssClass="boxbg" Wrap="false"   />
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr class="bgbluegrey">
                                    <td align="center" colspan="2">
                                        <asp:Button ID="Btn_Submit" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Text="Save and Continue >>" OnClientClick="javascript:return checkOnSubmit();" OnClick="Submit_Data" />
                                            
                                        <asp:Button ID="Btn_SubmitWithoutSave" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Text="Continue without saving >>" OnClick="Submit_WithoutSaving" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
