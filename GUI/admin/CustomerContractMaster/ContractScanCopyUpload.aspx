<%@ Page Language="C#" AutoEventWireup="true"
    CodeFile="ContractScanCopyUpload.aspx.cs" Inherits="GUI_admin_ContractScanCopyUpload"
    Title="Untitled Page" %>
<%@ Register Src="~/GUI/Common_UserControls/UserMessage.ascx" TagPrefix="ums" TagName="UserMessage" %>
<%@ Register Src="~/GUI/admin/CustomerContractMaster/CustContractInfo.ascx" TagName="CustInfo" TagPrefix="cust" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript">      
/*************************************************************************************************************
*   VALIDATION FOR ALL INPUT WHEN SUBMIT BUTTON CLICK
/*************************************************************************************************************/             
function btnSubmitCheck()
{       
        var uplTheFile = document.getElementById("uplTheFile");   
        if(uplTheFile.value == "")
        {
                alert("Please browse file to upload.");
                uplTheFile.focus();
                return false;
        }
        return true;
 }
 function topWindow(contractid,contractidFolder)
  {
      if (contractid != "") 
     {
        
         var strWinFeature1 = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"

         // var strPopupURL1 = "../../../UploadedImages/" + contractidFolder + "/" + contractid
         var strPopupURL1 = "../../../UploadedImages/" + contractid
         winNew = window.open(strPopupURL1, "_blank", strWinFeature1)
         return false;
     }
     else 
     {
         alert("Image is not Uploaded...");
         return false;
     }
 }

    </script>
</head> 
<body>
    <form id="form1" runat="server">
    <asp:Panel ID="Panel1" runat="server" Width="10in">     
 <asp:Table runat="server" CssClass="boxbg" HorizontalAlign="left" CellSpacing="1"
            Width="100%" ID="tblMain">
             <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell ColumnSpan="2" HorizontalAlign="Center" Font-Bold="true">
                        Scanned Contract Copy Upload 
                </asp:TableCell>
            </asp:TableRow>  
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell ColumnSpan="2">
                        <cust:CustInfo runat="server" ID="cstheader" /> 
                </asp:TableCell>
            </asp:TableRow>         
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell>
                            Select file 
                </asp:TableCell>
                <asp:TableCell>
                    <asp:FileUpload ID="uplTheFile" runat="server" BorderStyle="Groove" CssClass="blackfnt" tabindex="3" style="width: 350px" />                    
                </asp:TableCell>
            </asp:TableRow >
            <asp:TableRow CssClass="bgbluegrey" VerticalAlign="Middle">
                <asp:TableCell HorizontalAlign="center" ColumnSpan="2">
                    <asp:Button ID="btnUploadFile" runat="server" Text="Upload File" Width="100px" CssClass="blackfnt"
                       OnClientClick="javascript:return btnSubmitCheck()" TabIndex="4" OnClick="btnUploadFile_Click" />
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
            <asp:TableCell ColumnSpan="3">
            
              <asp:GridView HorizontalAlign="Center" ID="grvFileName" runat="server" CellSpacing="1"
            BorderWidth="0px" HeaderStyle-CssClass="hrow" AllowSorting="True" 
            AllowPaging="True" PagerStyle-HorizontalAlign="left" CssClass="ftbl" FooterStyle-CssClass="frow"
            SelectedRowStyle-Font-Bold="true" RowStyle-HorizontalAlign="Center" RowStyle-CssClass="nrow"
            AutoGenerateColumns="False" OnRowDataBound="grvFileName_OnRowDataBound"  EmptyDataText="No Records Found..."  Visible="true"
             Width="90%" 
             
             OnRowCommand="grvFileName_OnRowCommand"
               >
         <Columns >
         
           <asp:TemplateField HeaderText="FileName">
                    <ItemTemplate>
                        <asp:Label ID="lblFileName" CssClass="nfnt" Text=' <%# DataBinder.Eval( Container.DataItem,"Filename") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="UploadDate">
                    <ItemTemplate>
                        <asp:Label ID="lblDateTime" CssClass="nfnt" Text=' <%# DataBinder.Eval( Container.DataItem,"UploadDate") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            
            
        <asp:TemplateField >
                    <ItemTemplate>
                <asp:LinkButton  ID="lnkviewFile"  CssClass="nfnt" runat="server"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                     
          <asp:TemplateField >
                    <ItemTemplate>
                <asp:LinkButton  ID="lnkDeleteFile" CommandName="Select" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"Filename")%>'
  CssClass="nfnt" runat="server">
  </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
              
  </Columns>
                   <RowStyle CssClass="nrow" HorizontalAlign="Center" />
                
                   <FooterStyle CssClass="frow" />
            <PagerStyle HorizontalAlign="Center" CssClass="hrow" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                   <SelectedRowStyle Font-Bold="True" />
                  
                   <HeaderStyle CssClass="hrow"  />
                   
                    
        </asp:GridView>
            </asp:TableCell>
            
            </asp:TableRow>
        </asp:Table>
        
       
<%--<asp:Table runat="server" CssClass="boxbg" HorizontalAlign="left" CellSpacing="1"
            Width="100%" ID="Table1">
           
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell ColumnSpan="2">
                
               <asp:GridView HorizontalAlign="Center" ID="grvFileName1" runat="server" CellSpacing="1"
            BorderWidth="0px" HeaderStyle-CssClass="hrow" AllowSorting="True" 
            AllowPaging="True" PagerStyle-HorizontalAlign="left" CssClass="ftbl" FooterStyle-CssClass="frow"
            SelectedRowStyle-Font-Bold="true" RowStyle-HorizontalAlign="Center" RowStyle-CssClass="nrow"
            AutoGenerateColumns="False"  EmptyDataText="No Records Found..."  Visible="true"
             Width="90%"  >
         <Columns >
         
           <asp:TemplateField HeaderText="FileName">
                    <ItemTemplate>
                        <asp:Label ID="lblFileName" CssClass="nfnt" Text=' <%# DataBinder.Eval( Container.DataItem,"Filename") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="UploadDate">
                    <ItemTemplate>
                        <asp:Label ID="lblDateTime" CssClass="nfnt" Text=' <%# DataBinder.Eval( Container.DataItem,"UploadDate") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            
            
        <asp:TemplateField HeaderText=" Uploaded Copy">
                    <ItemTemplate>
                <asp:LinkButton  ID="lnkviewFile"  CssClass="nfnt" runat="server"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
              
  </Columns>
                   <RowStyle CssClass="nrow" HorizontalAlign="Center" />
                
                   <FooterStyle CssClass="frow" />
            <PagerStyle HorizontalAlign="Center" CssClass="hrow" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                   <SelectedRowStyle Font-Bold="True" />
                  
                   <HeaderStyle CssClass="hrow"  />
                   
                    
        </asp:GridView>
        
        
           </asp:TableCell>
                </asp:TableRow>
                </asp:Table>--%>
        
        <asp:HiddenField ID="hdnContractID" runat="server" />  
    </asp:Panel>    
    </form>
</body>
</html>

