const MODE = 'development';
const webpack = require('webpack');
const path = require('path');
const enabledSourceMap = (MODE === 'development');
const CleanWebpackPlugin = require('clean-webpack-plugin')

module.exports = {
  mode: MODE,
  entry: './assets/app.js',
  output: {
    filename: '[name].bundle.js',
    path: path.resolve(__dirname, 'public')
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        use: [
          {
            loader: 'babel-loader',
            options: {
              presets: [
                '@babel/preset-env',
              ]
            }
          }
        ]
      },
      {
        test: /\.js$/,
        exclude: /node_modules/
      },
      {
        test: /\.scss/,
        use: [
          'style-loader',
          {
            loader: 'css-loader',
            options: {
              url: false,
              sourceMap: enabledSourceMap,
              importLoaders: 2
            },
          },
          {
            loader: 'sass-loader',
            options: {
              sourceMap: enabledSourceMap,
            }
          }
        ],
      },
      {
        test: /\.(gif|png|jpg|eot|wof|woff|woff2|ttf|svg)$/,
        loader: 'url-loader'
      },
      {
        test: /favicon\.ico$/,
        use: 'file-loader?name=[name].[ext]',
      }
    ]
  },
  devServer: {
    contentBase: './dist',
    overlay: true,
    hot: true
  },
  plugins: [
    new webpack.HotModuleReplacementPlugin(),
    new CleanWebpackPlugin(['public']),
  ]
};