package uploadFileStatus;

import org.apache.commons.fileupload.ProgressListener;

public class UploadListener implements ProgressListener {

	private UploadStatus status;	// 紀錄上傳資訊的Java Bean
	
	public UploadListener(UploadStatus status) {
		// TODO Auto-generated constructor stub
		this.status = status;
	}
	
	@Override
	public void update(long bytesRead, long contentLength, int items) {
		// TODO Auto-generated method stub
		status.setBytesRead(bytesRead);
		status.setContentLength(contentLength);
		status.setItems(items);
	}

}
