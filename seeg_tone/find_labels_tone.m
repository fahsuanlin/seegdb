close all; clear all;

[vertices, label, colortable] = read_annotation('/Applications/freesurfer/subjects/fsaverage/label/lh.aparc.annot');

target_label={
    'parsopercularis';
    'parstriangularis';
    'rostralmiddlefrontal';
    };

for label_idx=1:length(target_label)
    [a,b]=ismember(colortable.struct_names,target_label{label_idx}); 
    idx=find(b);
    ll_idx=colortable.table(idx,5);

    ll=vertices(find(label==ll_idx));

    fn=sprintf('%s-lh.label',target_label{label_idx});

    inverse_write_label(ll,zeros(size(ll)),zeros(size(ll)),zeros(size(ll)), ones(size(ll)),fn);

    %colortable.struct_names{idx}
end;
