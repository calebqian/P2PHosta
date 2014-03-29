class HostaCentralControllerController < ApplicationController
  def registerPeer
    respond_to do |format|
      format.html {render :text => "registerPeer(peerIP, localPageList)| This is the registerPeer action. PeerClients should be registered here. Further authentication process is necessary. Peer CLients that already have hosted page chunks could send a local list of page that it has."}
    end
  end

  def registerBackup
      respond_to do |format|
      format.html {render :text => "registerBackup(BackupIP, localPageList)| This is the registerBackup action. BackupServers should be registered here. Further authentication process is necessary. BackupServers should be launched in the beginning and expected to be highly available, so this action is supposed to be invoked not as frequent as registerPeer."}
    end
  end

  def browsePage
      respond_to do |format|
      format.html {render :text => "browsePage(pageName)| This action should be invoked by a browser/user or the middleware in front of it. This action is supposed to find where the page is located and redirect the HTTP request."}
    end
  end

  def updatePage
      respond_to do |format|
      format.html {render :text => "updatePage(customerID, pageName) | This action is supposed to update a page and redistribute it to peers and backup servers. This action should be invoked by customers from a client software or front-end website. Those people are the managers who are using the hosting service to host their static webpages. This page would take the customer's indentity and authentication info, as well as the file name. If the file already exists for this particular customer, the existing file in the system will be overwritten and updated. Otherwise, this file is treated a new file to be uploaded to P2PHosta."}
    end
  end
  
end
