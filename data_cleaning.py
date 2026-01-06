import pandas as pd
import numpy as np

# df=pd.read_csv("F:/data_analisyt_project/project_1/Hospital+Patient+Records/data_dictionary.csv")

# df_cleaning=df.apply(lambda x:x.str.strip() if x.dtype=="object" else x)

# df_cleaning['Field']=df['Field'].fillna('TABLE_SUMMARY')

# df_cleaning['Table'] = df['Table'].str.strip().str.lower()
# # print(df['Table'].unique())
# df_cleaning=df_cleaning.drop_duplicates()
# print(df.head(10))

# df_cleaning.to_csv("F:/data_analisyt_project/project_1/Hospital+Patient+Records/data_dictionary.csv")

# --------------------
df=pd.read_csv("F:/data_analisyt_project/project_1/Hospital+Patient+Records/encounters.csv")
# df=df.apply(lambda x:x.str.strip() if x.dtype=="object" else x)
# df['Start']=pd.to_datetime(df['Start'])
# df['Stop']=pd.to_datetime(df['Stop'])

# df['Start']=df['Start'].dt.strftime('%Y-%m-%d to %H:%M:%S')
# df['Stop']=df['Stop'].dt.strftime('%Y-%m-%d to %H:%M:%S')

# df['Reasoncode']=df['Reasoncode'].fillna(0).astype(int)
# df['Reasondescription']=df['Reasondescription'].fillna('not specified').str.lower()
# df['EEncounterclass'] = df['Encounterclass'].str.lower()
# df.columns=[col.lower() for col in df.columns]

# df.drop_duplicates()
# df.to_csv("F:/data_analisyt_project/project_1/Hospital+Patient+Records/encounters.csv",index=False)
print(df)

# -------

# df=pd.read_csv("F:/data_analisyt_project/project_1/Hospital+Patient+Records/organizations.csv")

# df.columns=[col.capitalize() for col in df.columns]
# df=df.apply(lambda x:x.str.lower() if x.dtype=='object' else x)
# df=df.apply(lambda x:x.str.strip() if x.dtype=='object' else x)
# df.to_csv("F:/data_analisyt_project/project_1/Hospital+Patient+Records/organizations.csv",index=False)
# print(df)

# # ---------------------
# df=pd.read_csv("F:/data_analisyt_project/project_1/Hospital+Patient+Records/patients.csv")
# df.columns=[col.capitalize() for col in df.columns]
# df['Deathdate']=pd.to_datetime(df['Deathdate'].fillna(0))
# df['Birthdate']=pd.to_datetime(df['Birthdate'])

# df['First']=df['First'].str.replace(r'\d+',' ',regex=True)
# df['Last']=df['Last'].str.replace(r'\d+',' ',regex=True)
# df['Maiden']=df['Maiden'].str.replace(r'\d+',' ',regex=True).fillna('None')

# df['Suffix']=df['Suffix'].fillna('none')
# df['Marital']=df['Marital'].fillna('U')

# df['Zip'] = df['Zip'].fillna(0).astype(int).astype(str).str.zfill(5)

# print(df.head(10))
# df.to_csv("F:/data_analisyt_project/project_1/Hospital+Patient+Records/patients.csv",index=False)

# # ----------------------
# df=pd.read_csv("F:/data_analisyt_project/project_1/Hospital+Patient+Records/payers.csv")


# df.columns=[col.capitalize() for col in df.columns]

# col_fill=['Address','City','State_headquartered','Phone']
# for col in col_fill:
#     df[col]=df[col].fillna('N/A')

# df['Zip']=df['Zip'].fillna(0).astype(int).astype(str).str.zfill(5)
# df.loc[df['Zip']=='00000','Zip']='N/A'

# df.to_csv("F:/data_analisyt_project/project_1/Hospital+Patient+Records/payers.csv",index=False)
# print(df)

# # -----------------------
# df=pd.read_csv("F:/data_analisyt_project/project_1/Hospital+Patient+Records/procedures.csv")
# df.columns=[col.capitalize() for col in df.columns]
# df['Start']=pd.to_datetime(df['Start'])
# df['Stop']=pd.to_datetime(df['Stop'])
# df['Start']=df['Start'].dt.strftime('%Y-%m-%d to %H:%M:%S')
# df['Stop']=df['Stop'].dt.strftime('%Y-%m-%d to %H:%M:%S')

# df['Reasoncode']=df['Reasoncode'].fillna(0).astype(int).astype(str)
# df.loc[df['Reasoncode']=='0','Reasoncode']='N/A'
# df['Reasondescription']=df['Reasondescription'].fillna('N/A')
# df.drop_duplicates()
# df.to_csv("F:/data_analisyt_project/project_1/Hospital+Patient+Records/procedures.csv",index=False)
# print(df)