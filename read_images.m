function [Folder_List, T,Z] = read_images(Folder_Name)

%% Read Images from .stk and convert to tiff. Save as individual folders

Num_odors = dir(Folder_Name);
warning off
count = 1;

for ii = 1:length(Num_odors)   
    % Go through each stimulus folder. 
    if ~strncmp(Num_odors(ii).name,'.',1)
        if isdir([Folder_Name,Num_odors(ii).name])
            disp(['Creating Files for... ',Num_odors(ii).name])
            
            %Read .stk files and convert to tiff
            Num_files = dir([Folder_Name,Num_odors(ii).name,filesep,'*.stk']);           
            Folder_List{count} = {Num_odors(ii).name};
            T(count,:) = length(Num_files);
                       
            for jj = 1:length(Num_files)               
                disp(['Time Point... ',Num_files(jj).name])                
                % Read and compile .stk images
                [img_stack, img_read] = tiffread2([Folder_Name,Num_odors(ii).name,filesep,Num_files(jj).name]);               
                Z(count,:) = img_read;                
                
                %Save .tiff images
                for kk = 1:img_read                   
                    mkdir(fullfile([Folder_Name,Num_odors(ii).name,filesep,'Tiff',filesep,'Z_',int2str(kk),filesep]));
                    img_filename = [Num_files(jj).name(1:end-4), '.tif'];
                    temp_img = (img_stack(kk).data);                    
                    % Save images
                    imwrite(temp_img, fullfile([Folder_Name,Num_odors(ii).name,filesep,'Tiff',filesep,'Z_',int2str(kk),filesep, img_filename]) );
                end                
            end            
            count = count+1;           
        end        
    end
end