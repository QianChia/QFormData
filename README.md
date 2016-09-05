![Logo](https://avatars3.githubusercontent.com/u/13508076?v=3&s=460)
# QFormData

- A simple encapsulation of upload file data.

GitHub：[QianChia](https://github.com/QianChia) ｜ Blog：[QianChia(Chinese)](http://www.cnblogs.com/QianChia)

---
## Installation

### From CocoaPods

- `pod 'QFormData'`

### Manually
- Drag all source files under floder `QFormData` to your project.
- Import the main header file：`#import "QFormData.h"`

---
## Examples

- Single File Upload

	```objc
	
    	#define boundary @"uploadBoundary"
    
    	NSMutableData *formDataM = [NSMutableData data];
    
    	[formDataM q_setHttpHeaderFieldWithRequest:request fileBoundary:boundary];
    
    	[formDataM q_appendPartWithFileURL:fileURL 
    	                      fileBoundary:boundary 
    	                              name:@"userfile" 
    	                          fileName:@"test1.png" 
    	                          mimeType:@"image/png"];
    
    	[formDataM q_appendPartWithText:@"qian" textName:@"username" fileBoundary:boundary];
    
    	[formDataM q_appendPartEndingWithFileBoundary:boundary];
    
	```	

	```objc
	
		NSData *formData = [NSData q_formDataWithRequest:request 
		                                            text:@"qian" 
		                                        textName:@"username" 
		                                        fileData:filedata 
		                                            name:@"userfile" 
		                                        fileName:@"test2.png" 
		                                        mimeType:@"image/png"];
	
	```
- Multiple File Upload

	```objc
	
    	NSData *formData = [NSData q_formDataWithRequest:request
    	                                       fileDatas:@[filedata1, filedata2]
    	                                            name:@"userfile[]"
    	                                       fileNames:@[@"demoFile1.png", @"demoFile2.jpg"]
    	                                       mimeTypes:@[@"image/png", @"image/jpeg"]];
    
	``` 
	
	```objc
	
    	NSData *formData = [NSData q_formDataWithRequest:request
    	                                           texts:@[@"qian"]
    	                                       textNames:@[@"username"]
    	                                       fileDatas:@[filedata1, filedata2]
    	                                            name:@"userfile[]"
    	                                       fileNames:@[@"demoFile1.png", @"demoFile2.jpg"]
    	                                       mimeTypes:@[@"image/png", @"image/jpeg"]];
    
	``` 
	
	```objc
	
		NSData *formData = [NSData q_formDataWithRequest:request 
		                                        fileURLs:@[fileURL1, fileURL2] 
		                                            name:@"userfile[]" 
		                                       fileNames:@[@"demoFile1.png", @"demoFile2.jpg"] 
		                                       mimeTypes:@[@"image/png", @"image/jpeg"]];
	
	``` 
	
	```objc
	
		NSData *formData = [NSData q_formDataWithRequest:request 
		                                           texts:@[@"qian"] 
		                                       textNames:@[@"username"] 
		                                        fileURLs:@[fileURL1, fileURL2] 
		                                            name:@"userfile[]" 
		                                       fileNames:@[@"demoFile1.png", @"demoFile2.jpg"] 
		                                       mimeTypes:@[@"image/png", @"image/jpeg"]];
	
	``` 
	
   