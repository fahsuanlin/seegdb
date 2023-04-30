close all; clear all;

subject={
%     's013';
%     's014';
%     's015';
%     's017';
%     's018';
%     's019';
%     's020';
%     's021';
%     's022';
%     's023';
%     's024';
%     's025';
%     's026';
%     's027';
%     's028';
%     's029';
%     's031';
%     's032';
%     's033';
%     's034';
%     's035';
%     's036';
%     's037';
%     's038';
%     's039';
%     's041';
%     's042';
%     's044';
%     's045';
%     's046';
%     's047';
%     's048';
%     's049';
%     's050';
%     's051';
%     's052';
%     's053';
%     's054';
%     's055';
%     's056';
%     's057';
    's058';
    's059';
    's060';
    's061';
    's062';
    's063';
    's064';
    's065';
    's066';
    's067';
    's068';
    's069';
    's070';
    's071';
    };

path_mri='/Users/fhlin/workspace/seeg/subjects';

file_register='register.dat'; %a fixed file name; soft link has been created if necessary.

targ=MRIread('/Applications/freesurfer/subjects/fsaverage/mri/orig.mgz');

%file_mat='electrode_050521_100031_merge.mat'; %electrode coordinates in post-op MRI

%file_roi='electrodes_to_labels_120121.mat';
roi_index=[1:6]; %auditory cortex; left and right hemisphere
roi_index=[]; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
setenv('SUBJECTS_DIR',path_mri);

T = table;
for subj_idx=1:length(subject)
    % convert electrode coordinates from post-op MRI to MNI MRI
    mri=MRIread(sprintf('%s/%s/mri/orig.mgz',path_mri,subject{subj_idx})); %for MAC/Linux
    %
    xfm=etc_read_xfm('file_xfm',sprintf('%s/%s_post/tmp/%s',path_mri,subject{subj_idx},file_register)); %for MAC/Linux

    fprintf('loading transformation for subject %s]...\n',subject{subj_idx});
    mov_xfm=etc_read_xfm('subject',subject{subj_idx});

    %load electrode position mat file
    file_mat=dir(sprintf('%s/%s_contact_loc/*.mat',path_mri,subject{subj_idx}));

    for ff_idx=1:length(file_mat)
        fprintf('electrode mat file: [%s]...\n',file_mat(ff_idx).name);
        load(sprintf('%s/%s',file_mat(ff_idx).folder,file_mat(ff_idx).name));
    end;

    electrode_out=electrode;
    for e_idx=1:length(electrode)

        for c_idx=1:electrode(e_idx).n_contact

            surface_coord=electrode(e_idx).coord(c_idx,:);

            surface_coord=targ.tkrvox2ras*inv(targ.vox2ras)*mov_xfm*mri.vox2ras*inv(mri.tkrvox2ras)*inv(xfm)*[surface_coord(:); 1];

            electrode_out(e_idx).coord(c_idx,:)=surface_coord(1:3);

            e_now={subject{subj_idx},electrode_out(e_idx).name, sprintf('%s_%02d',electrode_out(e_idx).name,c_idx),surface_coord(1:3)'};
            T=[T; e_now];

        end;
    end;

    electrode=electrode_out;

    %[dummy,fstem]=fileparts(file_mat);

    %fprintf('\nmust load [%s] to locate electrodes in MNI MRI!\n\n',sprintf('%s_tal_%s.mat',fstem,subject));

    %save(sprintf('%s_tal_%s.mat',fstem,subject),'electrode');



    %ROI
    for roi_idx=1:length(roi_index)

        %find electrode and contact index
        if(~isempty(file_roi))
            load(file_roi);
            if(~isempty(electrode))
                for electrode_idx=1:length(electrode)
                    if(strcmp(electrode(electrode_idx).name,roi(roi_index(roi_idx)).electrode_min_dist_electrode_name))
                        electrode_idx_select=electrode_idx;
                    end;
                end;
            end;
            contact_idx_select=roi(roi_index(roi_idx)).electrode_min_dist_electrode_contact;
        else
            roi=[];
        end;

        E=electrode(electrode_idx_select);
        E.name=sprintf('%s_%s',E.name,subject);
        E.contact_idx=contact_idx_select;

        %save(sprintf('electrode_tal_mri_%s_120121.mat',roi(roi_index(roi_idx)).name),'E');

    end;

end;