import pandas as pd
import json

df = pd.read_csv('combinedData.csv')

def pandasActivityInfo():
	count = df['Activity'].value_counts()
	labels = df['Activity'].unique()

	df_count = pd.DataFrame(count, labels)
	df_count.reset_index(level=0, inplace=True)
	df_count.columns = ['Activity', 'Value']
	df_count['Value'] = df_count['Value'].astype(float)

	return df_count.to_dict()


def pandasActivityInfoJson():
	count = df['Activity'].value_counts()
	labels = df['Activity'].unique()

	df_count = pd.DataFrame(count, labels)
	df_count.reset_index(level=0, inplace=True)
	df_count.columns = ['Activity', 'Value']
	df_count['Value'] = df_count['Value'].astype(float)

	d = df_count.to_dict(orient='records')
	
	r = {
	 "data": d
	}

	return json.dumps(r)


def chartInfo(name, column):
	activity_name = name
	activity_df = df[df['Activity'] == activity_name]
	values = activity_df[column]
	values.reset_index(drop=True, inplace=True)

	df_values = pd.DataFrame(values)
	df_values.reset_index(level=0, inplace=True)
	df_values.columns = ['Index', 'Value']
	
	d = df_values.to_dict(orient='records')

	return d


def describeModelInfo():
	describe = df.describe()
	meanRow = df.describe().loc[['mean']]
	print(meanRow)

	return describe.to_dict()



