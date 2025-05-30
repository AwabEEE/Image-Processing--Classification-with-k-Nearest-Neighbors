% Set the folder containing the images
folder = 'images';
image_files = dir(fullfile(folder, '*.jpg'));

% Feature extraction function (example: average grayscale intensity)
extract_features = @(img) mean2(rgb2gray(img));

% Preprocess images and extract features
num_images = length(image_files);
features = zeros(num_images, 1);
labels = cell(num_images, 1);

figure('Name', 'Training Images');
for i = 1:num_images
    img = imread(fullfile(folder, image_files(i).name));
    features(i) = extract_features(img);
    labels{i} = image_files(i).name(1);
    
    % Display training images with labels
    subplot(2, ceil(num_images/2), i);
    imshow(img);
    title(['Label: ', labels{i}], 'Interpreter', 'none');
end

% Define number of neighbors (k)
k = 3;

% Train the kNN model
Mdl = fitcknn(features, labels, 'NumNeighbors', k);

% Load and display the new image for prediction
new_image_path = fullfile(folder, 'new_image.jpg');
new_image = imread(new_image_path);
new_feature = extract_features(new_image);
predicted_label = predict(Mdl, new_feature);

% Display predicted label
disp(['Predicted class label for new image: ', char(predicted_label)]);

% Show the test image and predicted label
figure('Name', 'Test Image');
imshow(new_image);
title(['Predicted label: ', char(predicted_label)], 'FontSize', 14);
